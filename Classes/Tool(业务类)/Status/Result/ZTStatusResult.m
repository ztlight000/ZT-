//
//  ZTStatusResult.m
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatusResult.h"

@implementation ZTStatusResult

+ (NSDictionary *)objectClassInArray{

    return @{@"statuses":[ZTStatus class]};
}
@end
