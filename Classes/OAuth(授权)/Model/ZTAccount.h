//
//  ZTAccount.h
//  ZT微博
//
//  Created by zywx on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

/*
 "access_token" = "2.00rgrSmFbkehbC7e6d1c76a9ZumKNB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5294424581;
 
 */

#import <Foundation/Foundation.h>

@interface ZTAccount : NSObject<NSCoding>

/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
