//
//  AppDelegate.m
//  ZT微博
//
//  Created by 张涛 on 16/2/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ZTTabBarController.h"
#import "ZTOneViewController.h"
#import "ZTNewfeatureController.h"
#import "ZTOAuthViewController.h"
#import "ZTRootTool.h"
#import "ZTAccountTool.h"
#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    // 注册通知,8.0之后图标才能显示消息数
    [application registerUserNotificationSettings:settings];
    
    //在真机上后台播放，设置视频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    //设置会话类型（AVAudioSessionCategoryPlayback后台播放）
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //激活
    [session setActive:YES error:nil];
    
    //创建窗口
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //选择根控制器
    //判断下有没有授权
    if ([ZTAccountTool account]) {// 已经授权
        
        // 选择根控制器
        [ZTRootTool chooseRootViewController:self.window];
        
    }else{
    
        //进行授权
        ZTOAuthViewController *oauthVc = [[ZTOAuthViewController alloc] init];
        
        self.window.rootViewController = oauthVc;
    
    }
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{

    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    //清除所有缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

// 失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
        
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
