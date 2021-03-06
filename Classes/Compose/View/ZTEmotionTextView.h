//
//  ZTEmotionTextView.h
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTTextView.h"
@class ZTEmotion;

@interface ZTEmotionTextView : ZTTextView
- (void)insertEmotion:(ZTEmotion *)emotion;

- (NSString *)fullText;
@end
