//
//  ZTEmotionPopView.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTEmotionPopView.h"
#import "ZTEmotion.h"
#import "ZTEmotionButton.h"

@interface ZTEmotionPopView()
@property (weak, nonatomic) IBOutlet ZTEmotionButton *emotionButton;
@end

@implementation ZTEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZTEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(ZTEmotionButton *)button
{
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}

@end
