//
//  ZTAccountTool.m
//  ZT微博
//
//  Created by zywx on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTAccountTool.h"
#import "ZTAccount.h"

#import "ZTAccountParam.h"
#import "MJExtension.h"
#import "ZTHttpTool.h"



#define ZTAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation ZTAccountTool

static ZTAccount *_account;

+ (void)saveAccount:(ZTAccount *)account{

    [NSKeyedArchiver archiveRootObject:account toFile:ZTAccountFileName];
}

+ (ZTAccount *)account{
    
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZTAccountFileName];
        
        //判断账号是否过期，过期返回nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            
            return nil;
            
        }
    }
    
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{

    ZTAccountParam *param = [[ZTAccountParam alloc] init];
    
    param.client_id = ZTClient_id;
    
    param.client_secret = ZTClient_secret;
    
    param.grant_type = @"authorization_code";
    
    param.redirect_uri = ZTRedirect_uri;
    
    param.code = code;
    
    //发送请求
    [ZTHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        
        //请求成功
        ZTLog(@"请求成功");
        
        // 字典转模型
        ZTAccount *account = [ZTAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [ZTAccountTool saveAccount:account];
        
        if (success) {
            
            success();
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
}

@end









