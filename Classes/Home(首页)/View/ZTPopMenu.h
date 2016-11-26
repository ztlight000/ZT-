//
//  ZTPopMenu.h
//  ZT微博
//
//  Created by zywx on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTPopMenu : UIImageView


/**
 *  显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

// 内容视图
@property (nonatomic, weak) UIView *contentView;

@end
