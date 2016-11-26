//
//  ZTRootTool.m
//  ZT微博
//
//  Created by zywx on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTRootTool.h"
#import "ZTNewfeatureController.h"
#import "ZTTabBarController.h"

#define ZTVersionKey @"ztversion"
@implementation ZTRootTool

+ (void)chooseRootViewController:(UIWindow *)window{
    
    //获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:ZTVersionKey];
    
    //判断是否有新特性
    if ([currentVersion isEqualToString:lastVersion]) {
        
        //创建tabBarVc
        ZTTabBarController *tabBarVc = [[ZTTabBarController alloc] init];
        
        //设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
    }else{
        
        ZTNewfeatureController *newfeatureVc = [[ZTNewfeatureController alloc] init];
        
        window.rootViewController = newfeatureVc;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:ZTVersionKey];
        
    }
    
}


@end
