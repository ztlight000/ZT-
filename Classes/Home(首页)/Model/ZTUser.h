//
//  ZTUser.h
//  ZT微博
//
//  Created by zywx on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic,copy) NSString *name;

/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;


@end
