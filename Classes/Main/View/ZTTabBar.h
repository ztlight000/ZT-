//
//  ZTTabBar.h
//  ZT微博
//
//  Created by 张涛 on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTTabBar;
@protocol ZTTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ZTTabBar *)tabBar didClickButton:(NSInteger)index;

//点击加号按钮调用
- (void)tabBarDidClickPlusButton:(ZTTabBar *)tabBar;

@end

@interface ZTTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<ZTTabBarDelegate> delegate;

@end
