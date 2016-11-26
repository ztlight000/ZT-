//
//  ZTComposeTool.m
//  ZT微博
//
//  Created by zywx on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTComposeTool.h"
#import "ZTHttpTool.h"
#import "ZTComposeParam.h"
#import "MJExtension.h"
#import "ZTUploadParam.h"

@implementation ZTComposeTool


+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    ZTComposeParam *param = [ZTComposeParam param];
    
    param.status = status;
    
    [ZTHttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        
        if (success) {
            
            success();
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];

}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    ZTComposeParam *param = [ZTComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    ZTUploadParam *uploadP = [[ZTUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";

    
}

@end
