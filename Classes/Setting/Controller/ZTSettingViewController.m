//
//  ZTSettingViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTSettingViewController.h"
#import "ZTBaseSetting.h"
#import "ZTCommonSettingViewController.h"

@implementation ZTSettingViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    // 账号管理
    ZTBadgeItem *account = [ZTBadgeItem itemWithTitle:@"账号管理"];
    
    account.badgeValue = @"8";
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[account];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 提醒和通知
    ZTArrowItem *notice = [ZTArrowItem itemWithTitle:@"我的相册" ];
    
    // 通用设置
    ZTArrowItem *setting = [ZTArrowItem itemWithTitle:@"通用设置" ];
    
    setting.destVcClass = [ZTCommonSettingViewController class];
    
    // 隐私与安全
    ZTArrowItem *secure = [ZTArrowItem itemWithTitle:@"隐私与安全" ];

    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[notice,setting,secure];
    
    [self.groups addObject:group];
}

- (void)setUpGroup2{
    
    // 意见反馈
    ZTArrowItem *suggest = [ZTArrowItem itemWithTitle:@"意见反馈" ];
    
    // 关于微博
    ZTArrowItem *about = [ZTArrowItem itemWithTitle:@"关于微博"];
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[suggest,about];
    
    [self.groups addObject:group];
}

- (void)setUpGroup3
{
    // 账号管理
    ZTLabelItem *layout = [[ZTLabelItem alloc] init];
    
    layout.text = @"退出当前账号";
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[layout];
    
    [self.groups addObject:group];
}

@end
