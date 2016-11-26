//
//  ZTTextView.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTTextView.h"


@interface ZTTextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation ZTTextView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        
    }
    
    return self;

}

//懒加载
- (UILabel *)placeHolderLabel{

    if (_placeHolderLabel == nil) {
        
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        
        [self addSubview:placeHolderLabel];
        
        _placeHolderLabel = placeHolderLabel;
        
    }
    
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font{

    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    
    //label的尺寸跟文字一样大
    [self.placeHolderLabel sizeToFit];
}

- (void)setPlaceHolder:(NSString *)placeHolder{

    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    
    [self.placeHolderLabel sizeToFit];
    
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder{

    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    
    self.placeHolderLabel.y = 8;
    
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    
}


@end
