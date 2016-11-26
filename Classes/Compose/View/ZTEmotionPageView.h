//
//  ZTEmotionPageView.h
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>

// 一页中最多3行
#define ZTEmotionMaxRows 3
// 一行中最多7列
#define ZTEmotionMaxCols 7
// 每一页的表情个数
#define ZTEmotionPageSize ((ZTEmotionMaxRows * ZTEmotionMaxCols) - 1)

@interface ZTEmotionPageView : UIView
/** 这一页显示的表情（里面都是ZTEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;
@end
