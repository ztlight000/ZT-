//
//  ZTUserTool.h
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZTUserResult,ZTUser;



@interface ZTUserTool : NSObject

/**
 *  请求用户的未读信息数
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)unreadWithSuccess:(void (^)(ZTUserResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)userInfoWithSuccess:(void (^)(ZTUser *user))success failure:(void (^)(NSError *error))failure;

@end
