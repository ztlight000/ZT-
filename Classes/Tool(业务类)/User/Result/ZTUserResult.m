//
//  ZTUserResult.m
//  ZT微博
//
//  Created by 张涛 on 16/3/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTUserResult.h"

@implementation ZTUserResult

- (int)messageCount{

    return _cmt + _dm + _mention_status + _mention_cmt;
    
}

- (int)totoalCount{

    return self.messageCount + _status + _follower;
    
}

@end
