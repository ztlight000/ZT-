//
//  ZTEmotionTool.h
//  ZT微博
//
//  Created by 张涛 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZTEmotion;

@interface ZTEmotionTool : NSObject
+ (void)addRecentEmotion:(ZTEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (ZTEmotion *)emotionWithChs:(NSString *)chs;

@end
