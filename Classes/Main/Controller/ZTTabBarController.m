//
//  ZTTabBarController.m
//  ZT微博
//
//  Created by 张涛 on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTTabBarController.h"
#import "UIImage+Image.h"
#import "ZTTabBar.h"
#import <objc/message.h>

#import "ZTHomeViewController.h"
#import "ZTDiscoverViewController.h"
#import "ZTMessageViewController.h"
#import "ZTProfileViewController.h"

#import "ZTNavigationController.h"

#import "ZTUserTool.h"
#import "ZTUser.h"
#import "ZTUserResult.h"

#import "ZTComposeViewController.h"

@interface ZTTabBarController ()<ZTTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) ZTHomeViewController *home;

@property (nonatomic, weak) ZTMessageViewController *message;

@property (nonatomic, weak) ZTDiscoverViewController *discover;

@property (nonatomic, weak) ZTProfileViewController *profile;


@end

@implementation ZTTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];

    //定时器读取信息未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}

- (void)requestUnread{
    
    ZTLog(@"%s",__func__);
    
    [ZTUserTool unreadWithSuccess:^(ZTUserResult *result) {
        
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];

        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        //设置应用程序所有的为读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
    } failure:^(NSError *error) {
        
        
        
    }];

}

#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
//    ZTTabBar *tabBar = [[ZTTabBar alloc] initWithFrame:self.tabBar.bounds];
    ZTTabBar *tabBar = [[ZTTabBar alloc] initWithFrame:self.tabBar.frame];
    
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
//    [self.tabBar addSubview:tabBar];
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(ZTTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) {
        
        [_home refresh];
        
    }
    
    self.selectedIndex = index;
}

- (void)tabBarDidClickPlusButton:(ZTTabBar *)tabBar{

    ZTComposeViewController *composeVC = [[ZTComposeViewController alloc] init];
    
    ZTNavigationController *nav = [[ZTNavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


#pragma mark - 添加所有的自控制器
- (void)setUpAllChildViewController{

    //首页
    ZTHomeViewController *home = [[ZTHomeViewController alloc] init];
    
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
    _home = home;
    
    //消息
    ZTMessageViewController *message = [[ZTMessageViewController alloc] init];
    
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    
    //发现
    ZTDiscoverViewController *discover = [[ZTDiscoverViewController alloc] init];
    
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    //我
    ZTProfileViewController *profile = [[ZTProfileViewController alloc] init];
    
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    
}

- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];

    ZTNavigationController *nav = [[ZTNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
