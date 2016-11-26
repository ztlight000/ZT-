//
//  ZTPopMenu.m
//  ZT微博
//
//  Created by zywx on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTPopMenu.h"

@implementation ZTPopMenu

+ (instancetype)showInRect:(CGRect)rect{

    ZTPopMenu *popMenu = [[ZTPopMenu alloc] initWithFrame:rect];
    
    popMenu.userInteractionEnabled = YES;
    
    popMenu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [ZTKeyWindow addSubview:popMenu];
    
    return popMenu;
}

+ (void)hide{
    
    for (UIView *popView in ZTKeyWindow.subviews) {
        
        if ([popView isKindOfClass:self]) {
            
            [popView removeFromSuperview];
            
        }
    }
    
}

// 设置内容视图
- (void)setContentView:(UIView *)contentView
{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

@end
