//
//  ZTEmotionTabBar.h
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>

typedef enum {
    ZTEmotionTabBarButtonTypeRecent, // 最近
    ZTEmotionTabBarButtonTypeDefault, // 默认
    ZTEmotionTabBarButtonTypeEmoji, // emoji
    ZTEmotionTabBarButtonTypeLxh, // 浪小花
} ZTEmotionTabBarButtonType;

@class ZTEmotionTabBar;

@protocol ZTEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(ZTEmotionTabBar *)tabBar didSelectButton:(ZTEmotionTabBarButtonType)buttonType;
@end

@interface ZTEmotionTabBar : UIView
@property (nonatomic, weak) id<ZTEmotionTabBarDelegate> delegate;
@end
