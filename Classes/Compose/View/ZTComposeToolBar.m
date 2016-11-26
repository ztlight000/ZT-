//
//  ZTComposeToolBar.m
//  ZT微博
//
//  Created by 张涛 on 16/3/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTComposeToolBar.h"

@interface ZTComposeToolBar()
@property (nonatomic, weak) UIButton *emotionButton;
@end

@implementation ZTComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildView];
        
    }
    
    return self;
}

#pragma mark - 添加所有的子控件
- (void)setUpAllChildView{

    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    
    // 初始化按钮
    [self setUpButtonWithImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:ZTComposeToolbarButtonTypeCamera];
    
    [self setUpButtonWithImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:ZTComposeToolbarButtonTypePicture];
    
    [self setUpButtonWithImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:ZTComposeToolbarButtonTypeMention];
    
    [self setUpButtonWithImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:ZTComposeToolbarButtonTypeTrend];
    
    self.emotionButton = [self setUpButtonWithImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:ZTComposeToolbarButtonTypeEmotion];
}

- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];

}

/**
 * 创建一个按钮
 */
- (UIButton *)setUpButtonWithImage:(NSString *)image highImage:(NSString *)highImage type:(ZTComposeToolbarButtonType)type{
    
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = type;
    
    [self addSubview:btn];
    
    return btn;
}

- (void)btnClick:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        
        ZTLog(@"%ld", button.tag);
        
        [self.delegate composeToolbar:self didClickButton:button.tag];
    }

}

- (void)layoutSubviews{

    NSInteger count = self.subviews.count;
    
    CGFloat x = 0;
    
    CGFloat y = 0;
    
    CGFloat w = self.width / count;
    
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        
        btn.frame = CGRectMake(x, y, w, h);
        
    }

}




@end
