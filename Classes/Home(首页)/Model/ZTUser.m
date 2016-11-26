//
//  ZTUser.m
//  ZT微博
//
//  Created by zywx on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTUser.h"

@implementation ZTUser

- (void)setMbtype:(int)mbtype{

    _mbtype = mbtype;
    
    _vip = _mbtype > 2;
}

@end
