
//
//  ZTCover.m
//  ZT微博
//
//  Created by zywx on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTCover.h"

@implementation ZTCover

// 设置浅灰色蒙板
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}
// 显示蒙板
+ (instancetype)show
{
    ZTCover *cover = [[ZTCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [ZTKeyWindow addSubview:cover];
    
    return cover;
    
}

// 点击蒙板的时候做事情
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        
        [_delegate coverDidClickCover:self];
        
    }
    
}
@end
