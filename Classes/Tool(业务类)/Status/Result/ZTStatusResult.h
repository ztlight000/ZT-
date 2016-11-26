//
//  ZTStatusResult.h
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ZTStatus.h"

@interface ZTStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（ZTStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int *total_number;


@end
