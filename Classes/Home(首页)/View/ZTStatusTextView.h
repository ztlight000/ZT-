//
//  ZTStatusTextView.h
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//  用来显示微博正文的textView

#import <UIKit/UIKit.h>

@interface ZTStatusTextView : UITextView
/** 所有的特殊字符串(里面存放着ZTSpecial) */
@property (nonatomic, strong) NSArray *specials;
@end
