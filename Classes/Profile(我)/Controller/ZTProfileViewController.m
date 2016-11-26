//
//  ZTProfileViewController.m
//  ZT微博
//
//  Created by zywx on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTProfileViewController.h"
#import "ZTBaseSetting.h"
#import "ZTProfileCell.h"
#import "ZTSettingViewController.h"

@interface ZTProfileViewController ()


@end

@implementation ZTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    // 添加第0组
    [self setUpGroup0];
    
    // 添加第1组
    [self setUpGroup1];
    
    // 添加第2组
    [self setUpGroup2];
    
    // 添加第3组
    [self setUpGroup3];
    
}

- (void)setUpGroup0
{
    // 新的好友
    ZTArrowItem *friend = [ZTArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[friend];
    
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 我的相册
    ZTArrowItem *album = [ZTArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    
    album.subTitle = @"(12)";
    
    // 我的收藏
    ZTArrowItem *collect = [ZTArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    
    collect.subTitle = @"(0)";
    
    // 赞
    ZTArrowItem *like = [ZTArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    
    like.subTitle = @"(0)";
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[album,collect,like];
    
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 微博支付
    ZTArrowItem *pay = [ZTArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    
    // 个性化
    ZTArrowItem *vip = [ZTArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    
    vip.subTitle = @"微博来源、皮肤、封面图";
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[pay,vip];
    
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 我的二维码
    ZTArrowItem *card = [ZTArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    
    // 草稿箱
    ZTArrowItem *draft = [ZTArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[card,draft];
    
    [self.groups addObject:group];
}


- (void)setUpNav
{
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = setting;
    
}


#pragma mark - 点击设置的时候调用
- (void)setting
{
    
    NSLog(@"%s",__func__);
    
    ZTSettingViewController *settingVC = [[ZTSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZTProfileCell *cell = [ZTProfileCell cellWithTableView:tableView];
    
    // 获取模型
    ZTGroupItem *groupItem = self.groups[indexPath.section];
    
    ZTSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    
    return cell;
    
}

@end
