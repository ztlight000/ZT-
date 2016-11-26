//
//  ZTHttpTool.h
//  ZT微博
//
//  Created by zywx on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZTUploadParam;

@interface ZTHttpTool : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
                    parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Post:(NSString *)URLString
                    parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  上传请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(ZTUploadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

@end
