//
//  ZTUserTool.m
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTUserTool.h"
#import "ZTHttpTool.h"
#import "ZTUserParam.h"
#import "ZTAccountTool.h"
#import "ZTAccount.h"
#import "MJExtension.h"

#import "ZTUserResult.h"
#import "ZTUser.h"

@implementation ZTUserTool

+ (void)unreadWithSuccess:(void (^)(ZTUserResult *result))success failure:(void (^)(NSError *error))failure{
    
    ZTUserParam *param = [ZTUserParam param];
    
    param.uid = [ZTAccountTool account].uid;

    [ZTHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        ZTUserResult *result = [ZTUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            
            success(result);
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}

+ (void)userInfoWithSuccess:(void (^)(ZTUser *user))success failure:(void (^)(NSError *error))failure{
    
    ZTUserParam *param = [ZTUserParam param];
    
    param.uid = [ZTAccountTool account].uid;
    
    [ZTHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        ZTUser *user = [ZTUser objectWithKeyValues:responseObject];
        
        if (success) {
            
            success(user);
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
}


@end
