//
//  ZTBaseParam.m
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTBaseParam.h"
#import "ZTAccountTool.h"
#import "ZTAccount.h"

@implementation ZTBaseParam

+ (instancetype)param{

    ZTBaseParam *param = [[self alloc] init];
    
    param.access_token = [ZTAccountTool account].access_token;
    
    return param;

}

@end
