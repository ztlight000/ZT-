//
//  ZTStatusToolBarView.m
//  ZT微博
//
//  Created by zywx on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatusToolBar.h"
#import "ZTStatus.h"

@interface ZTStatusToolBar ()


@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideVs;


@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation ZTStatusToolBar


- (NSMutableArray *)btns{

    if (_btns == nil) {
        
        _btns = [[NSMutableArray alloc] init];
        
    }
    
    return _btns;
}

- (NSMutableArray *)divideVs{

    if (_divideVs == nil) {
        
        _divideVs = [[NSMutableArray alloc] init];
        
    }
    
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
        
    }
    
    return self;
    
}

// 添加所有子控件
- (void)setUpAllChildView
{
    //转发
    UIButton *retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    
    _retweet = retweet;
    
    //评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    
    _comment = comment;
    
    //赞
    UIButton *unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    
    _unlike = unlike;
    
    
    for (int i = 0; i < _btns.count - 1; i++) {
        
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        
        [self addSubview:divideV];
        
        [self.divideVs addObject:divideV];
    }
    
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)titile image:(UIImage *)image{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:titile forState:UIControlStateNormal];
    
    [btn setImage:image forState:UIControlStateNormal];

    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger count = _btns.count;
    
    float w = ZTScreenW / count;
    
    float h = self.height;
    
    float x = 0;
    
    float y = 0;
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *btn = self.btns[i];
        
        x = i * w;
        
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    NSInteger i = 1;
    
    for (UIImageView *dicive in self.divideVs) {
        
        UIButton *btn = self.btns[i];
        
        dicive.x = btn.x;
        
        i++;
        
    }
    
}

- (void)setStatus:(ZTStatus *)status{

    _status = status;
    
    // 设置转发的标题
    [self setBtn:_retweet title:status.reposts_count];
    
    // 设置评论的标题
    [self setBtn:_comment title:status.comments_count];
    
    // 设置赞
    [self setBtn:_unlike title:status.attitudes_count];

}

- (void)setBtn:(UIButton *)btn title:(int)count{

    NSString *title = nil;
    
    if (count) {
        
        if (count > 10000) {
            
            CGFloat floatCount = count / 10000.0;
            
            title = [NSString stringWithFormat:@"%.1fw",floatCount];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }else{
            
            title = [NSString stringWithFormat:@"%d",count];
            
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
        
    }

}

@end






