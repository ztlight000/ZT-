//
//  ZTAccountTool.h
//  ZT微博
//
//  Created by zywx on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTAccount;
@interface ZTAccountTool : NSObject

+ (void)saveAccount:(ZTAccount *)account;

+ (ZTAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
