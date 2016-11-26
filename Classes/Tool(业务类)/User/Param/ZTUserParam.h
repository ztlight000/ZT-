//
//  ZTUserParam.h
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTBaseParam.h"


@interface ZTUserParam : ZTBaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
