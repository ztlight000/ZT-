//
//  ZTStatusTool.h
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTStatusTool : NSObject

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;

+ (void)moreStatusWithMaxId:(NSString *)MaxId success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure;


@end
