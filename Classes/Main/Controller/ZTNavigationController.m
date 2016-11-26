//
//  ZTNavigationController.m
//  ZT微博
//
//  Created by zywx on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTNavigationController.h"
#import "ZTTabBar.h"

@interface ZTNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation ZTNavigationController

+ (void)initialize{

    //获取当前类下面的所有UIBarButtonItem
    UIBarButtonItem *items = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //设置导航条按钮的title颜色
    NSMutableDictionary *titleAttr = [[NSMutableDictionary alloc] init];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [items setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条背景色
//    self.navigationBar.barTintColor = [UIColor orangeColor];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[ZTTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        
        //返回跟控制器后要添加上此前取消的代理要不然会崩溃
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else{ // 非根控制器
        
        //自定义push方法之后需要设置此代理才能实现手势滑动切换
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
