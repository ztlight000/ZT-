//
//  ZTSpecial.m
//  ZT微博
//
//  Created by zywx on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTSpecial.h"

@implementation ZTSpecial
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
