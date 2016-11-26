//
//  ZTEmotionAttachment.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.

#import "ZTEmotionAttachment.h"
#import "ZTEmotion.h"

@implementation ZTEmotionAttachment
- (void)setEmotion:(ZTEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
