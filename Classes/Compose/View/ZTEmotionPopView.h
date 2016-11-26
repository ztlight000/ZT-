//
//  ZTEmotionPopView.h
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ZTEmotion, ZTEmotionButton;

@interface ZTEmotionPopView : UIView
+ (instancetype)popView;

- (void)showFrom:(ZTEmotionButton *)button;
@end
