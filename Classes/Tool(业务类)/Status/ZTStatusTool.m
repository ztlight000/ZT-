//
//  ZTStatusTool.m
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatusTool.h"
#import "ZTHttpTool.h"
#import "ZTStatus.h"
#import "ZTAccountTool.h"
#import "ZTAccount.h"
#import "ZTStatusParam.h"
#import "ZTStatusResult.h"

@implementation ZTStatusTool


+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{

    
    // 创建参数模型
    ZTStatusParam *param = [[ZTStatusParam alloc] init];
    
    param.access_token = [ZTAccountTool account].access_token;
    
    if (sinceId) { // 有微博数据，才需要下拉刷新
        
        param.since_id = sinceId;
    }
    
    [ZTHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {// 请求成功的时候调用
        
        // 把结果字典转换结果模型
        ZTStatusResult  *result = [ZTStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            
            success(result.statuses);
            
        }
        
    } failure:^(NSError *error) {
        
        if (error) {
            
            failure(error);
            
        }
    }];

}

+ (void)moreStatusWithMaxId:(NSString *)MaxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{

    
    // 创建一个参数字典
    ZTStatusParam *params = [[ZTStatusParam alloc] init];
    
    if (MaxId) { // 有微博数据，才需要下拉刷新
        
        params.max_id = MaxId;
    }
    
    params.access_token = [ZTAccountTool account].access_token;
    
    
    [ZTHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {// 请求成功的时候调用

        ZTStatusResult  *result = [ZTStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            
            success(result.statuses);
            
        }
        
    } failure:^(NSError *error) {
        
        if (error) {
            
            failure(error);
            
        }
    }];

}

@end














