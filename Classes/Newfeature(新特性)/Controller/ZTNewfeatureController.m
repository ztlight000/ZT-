//
//  ZTNewfeatureController.m
//  ZT微博
//
//  Created by zywx on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTNewfeatureController.h"
#import "ZTNewfearureCell.h"
@interface ZTNewfeatureController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation ZTNewfeatureController

static NSString *ID = @"cell";

- (instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 清空行距
    layout.minimumLineSpacing = 0;
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //一定要注册cell
    [self.collectionView registerClass:[ZTNewfearureCell class] forCellWithReuseIdentifier:ID];
    
    //分页
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageController
    [self setUpPageControl];

}

// 添加pageController
- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    
    control.pageIndicatorTintColor = [UIColor blackColor];
    
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.95);
    
    _control = control;
    
    [self.view addSubview:control];
}

#pragma mark - UIScrollView代理
// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZTNewfearureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 拼接图片名称 3.5 320 480
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    
    if (screenH > 480) { // 5 , 6 , 6 plus
        
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
        
    }
    
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

@end







