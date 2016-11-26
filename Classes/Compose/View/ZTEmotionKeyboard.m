//
//  ZTEmotionKeyboard.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTEmotionKeyboard.h"
#import "ZTEmotionListView.h"
#import "ZTEmotionTabBar.h"
#import "ZTEmotion.h"
#import "MJExtension.h"
#import "ZTEmotionTool.h"

@interface ZTEmotionKeyboard() <ZTEmotionTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) ZTEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) ZTEmotionListView *recentListView;
@property (nonatomic, strong) ZTEmotionListView *defaultListView;
@property (nonatomic, strong) ZTEmotionListView *emojiListView;
@property (nonatomic, strong) ZTEmotionListView *lxhListView;
/** tabbar */
@property (nonatomic, weak) ZTEmotionTabBar *tabBar;
@end

@implementation ZTEmotionKeyboard


#pragma mark - 懒加载
- (ZTEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[ZTEmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [ZTEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (ZTEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[ZTEmotionListView alloc] init];
        self.defaultListView.emotions = [ZTEmotionTool defaultEmotions];
    }
    return _defaultListView;
}

- (ZTEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[ZTEmotionListView alloc] init];
        self.emojiListView.emotions = [ZTEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (ZTEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[ZTEmotionListView alloc] init];
        self.lxhListView.emotions = [ZTEmotionTool lxhEmotions];
    }
    return _lxhListView;
}

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        ZTEmotionTabBar *tabBar = [[ZTEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        [ZTNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:ZTEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

#pragma mark - ZTEmotionTabBarDelegate
- (void)emotionTabBar:(ZTEmotionTabBar *)tabBar didSelectButton:(ZTEmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case ZTEmotionTabBarButtonTypeRecent: { // 最近
            ZTLog(@"%s",__func__);
            [self addSubview:self.recentListView];
//            self.showingListView = self.recentListView;
            break;
        }
            
        case ZTEmotionTabBarButtonTypeDefault: { // 默认
            ZTLog(@"%s",__func__);
            [self addSubview:self.defaultListView];
//            self.showingListView = self.defaultListView;
            break;
        }
            
        case ZTEmotionTabBarButtonTypeEmoji: { // Emoji
            ZTLog(@"%s",__func__);
            [self addSubview:self.emojiListView];
//            self.showingListView = self.emojiListView;
            break;
        }
            
        case ZTEmotionTabBarButtonTypeLxh: { // Lxh
            ZTLog(@"%s",__func__);
            [self addSubview:self.lxhListView];
//            self.showingListView = self.lxhListView;
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}

- (void)emotionDidSelect
{
    self.recentListView.emotions = [ZTEmotionTool recentEmotions];
}

- (void)dealloc
{
    [ZTNotificationCenter removeObserver:self];
}


@end
