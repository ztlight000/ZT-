//
//  ZTHomeViewController.m
//  ZT微博
//
//  Created by zywx on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTHomeViewController.h"

#import "UIBarButtonItem+Item.h"
#import "ZTTitleButton.h"

#import "ZTPopMenu.h"
#import "ZTCover.h"
#import "ZTOneViewController.h"

#import "AFNetworking.h"
#import "ZTAccountTool.h"
#import "ZTAccount.h"

#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ZTStatus.h"
#import "ZTHttpTool.h"
#import "ZTStatusTool.h"
#import "ZTUserTool.h"

#import "ZTStatusFrame.h"
#import "ZTStatus.h"
#import "ZTStatusCell.h"

@interface ZTHomeViewController ()<ZTCoverDelegate>

@property (nonatomic, weak) ZTTitleButton *titleButton;

@property (nonatomic, strong) ZTOneViewController *one;

/**
 *  ViewModel:ZTStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation ZTHomeViewController

- (NSMutableArray *)statusFrames{

    if (_statusFrames == nil) {
        
        _statusFrames = [NSMutableArray array];
        
    }
    
    return _statusFrames;
}

- (ZTOneViewController *)one
{
    if (_one == nil) {
        _one = [[ZTOneViewController alloc] init];

    }
    
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpNavgationBar];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    // 一开始展示之前的微博名称，然后在发送用户信息请求，直接赋值
    
    // 请求当前用户的昵称
    [self getTitleName];
}

- (void)getTitleName{

    [ZTUserTool userInfoWithSuccess:^(ZTUser *user) {
        
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 获取当前的账号
        ZTAccount *account = [ZTAccountTool account];
        
        account.name = user.name;
        
        // 保存用户的名称
        [ZTAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        
        ZTLog(@"%@",error);
        
    }];

}

- (void)refresh{

    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 设置导航条
- (void)setUpNavgationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    ZTTitleButton *titleButton = [ZTTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    NSString *titleName = [ZTAccountTool account].name?[ZTAccountTool account].name:@"首页";
    [titleButton setTitle:titleName forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    // 弹出蒙板
    ZTCover *cover = [ZTCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    ZTPopMenu *menu = [ZTPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(ZTCover *)cover
{
    // 隐藏pop菜单
    [ZTPopMenu hide];
    
    _titleButton.selected = NO;
    
}

- (void)friendsearch
{
    //    NSLog(@"%s",__func__);
}

- (void)pop
{
    ZTOneViewController *one = [[ZTOneViewController alloc] init];
    //push的时候就会隐藏底部条
    one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:one animated:YES];
//        [_titleButton setTitle:@"首页首页" forState:UIControlStateNormal];
//    [_titleButton setImage:nil forState:UIControlStateNormal];
//        [_titleButton sizeToFit];
}

#pragma mark - 请求更多旧的微博
- (void)loadMoreStatus
{
    
    NSString *maxIdStr = nil;
    
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        
        ZTStatus *s = [self.statusFrames[_statusFrames.count - 1] status];
        
        long long maxId = [s.idstr longLongValue] - 1;
        
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
        
    }

    [ZTStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [[NSMutableArray alloc] init];
        
        for (ZTStatus *status in statuses) {
            
            ZTStatusFrame *statusF = [[ZTStatusFrame alloc] init];
            
            statusF.status = status;
            
            [statusFrames addObject:statusF];
            
        }
        
        // 把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        // 刷新表格
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        ZTLog(@"%@",error);
        
    }];
    
}

#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        
        sinceId = [self.statusFrames[0] status].idstr;
    }
    
    [ZTStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        
        NSLog(@"请求成功==>>%@",statuses);
        
        // 请求成功的时候调用
        
        [self showNewStatusCount:statuses.count];
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [[NSMutableArray alloc] init];
        
        for (ZTStatus *status in statuses) {
            
            ZTStatusFrame *statusF = [[ZTStatusFrame alloc] init];
            
            statusF.status = status;
            
            [statusFrames addObject:statusF];
            
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        ZTLog(@"%@",error);
        
    }];
    
}

- (void)showNewStatusCount:(NSInteger)count{

    if (count <= 0) {
        
        return;
    
    }
    CGFloat h = 35;
    
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    CGFloat x = 0;
    
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    label.text = [NSString stringWithFormat:@"%ld 条新微薄",count];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor whiteColor];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    //插入到导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        
        //往上面平移
        [UIView animateKeyframesWithDuration:0.5 delay:2 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            //还原
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {

            [label removeFromSuperview];
            
        }];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZTStatusCell *cell = [ZTStatusCell cellWithTableView:tableView];
    
    ZTStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    cell.statusFrame = statusFrame;
    
//    static NSString *ID = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    
//    ZTStatus *status = self.statuses[indexPath.row];
//    
//    cell.textLabel.text = status.user.name;
//    
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZTStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;

}

@end
