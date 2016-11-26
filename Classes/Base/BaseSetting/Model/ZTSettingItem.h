//
//  ZTSettingItem.h
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//  描述每个cell长什么样子

#import <Foundation/Foundation.h>
@class ZTCheakItem;
@interface ZTSettingItem : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) UIImage *image;

/**
 *  保存每一行需要做的事情
 */
@property (nonatomic, copy) void(^option)(ZTCheakItem *item);

/**
 *  目标控制器的类名
 */
@property (nonatomic, assign) Class destVcClass;


+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;

@end
