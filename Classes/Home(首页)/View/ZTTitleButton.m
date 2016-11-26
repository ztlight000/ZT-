//
//  ZTTitleButton.m
//  ZT微博
//
//  Created by zywx on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTTitleButton.h"

@implementation ZTTitleButton

- (instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
    
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        
        return;
        
    }

    self.titleLabel.x = 0;

    // image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);

}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}

@end
