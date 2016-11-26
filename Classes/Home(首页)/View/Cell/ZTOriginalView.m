//
//  ZTOriginalView.m
//  ZT微博
//
//  Created by zywx on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTOriginalView.h"
#import "ZTStatusFrame.h"
#import "ZTStatus.h"

#import "UIImageView+WebCache.h"
#import "ZTUser.h"

#import "ZTPhotosView.h"
#import "ZTStatusTextView.h"

@interface ZTOriginalView ()

//头像
@property (nonatomic, weak) UIImageView *iconView;

//昵称
@property (nonatomic, weak) UILabel *nameView;

//vip
@property (nonatomic, weak) UIImageView *vipView;

//时间
@property (nonatomic, weak) UILabel *timeView;

//来源
@property (nonatomic, weak) UILabel *sourceView;

//正文
@property (nonatomic, weak) ZTStatusTextView *textView;
//@property (nonatomic, weak) UILabel *textView;

//配图
@property (nonatomic, weak) ZTPhotosView *photosView;

@end


@implementation ZTOriginalView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
        
    }
    
    return self;
    
}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    
    [self addSubview:iconView];
    
    _iconView = iconView;
    
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    
    nameView.font = ZTNameFont;
    
    [self addSubview:nameView];
    
    _nameView = nameView;
    
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    
    [self addSubview:vipView];
    
    _vipView = vipView;
    
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    
    timeView.font = ZTTimeFont;
    
    [self addSubview:timeView];
    
    _timeView = timeView;
    
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    
    sourceView.font = ZTSourceFont;
    
    [self addSubview:sourceView];
    
    _sourceView = sourceView;
    
    
    // 正文
    ZTStatusTextView *textView = [[ZTStatusTextView alloc] init];
    
    textView.font = ZTTextFont;
    
//    textView.numberOfLines = 0;
    
    [self addSubview:textView];
    
    _textView = textView;
    
    
    //配图
    ZTPhotosView *photosView = [[ZTPhotosView alloc] init];
    
    [self addSubview:photosView];
    
    _photosView = photosView;
}

- (void)setStatusFrame:(ZTStatusFrame *)statusFrame{

    _statusFrame = statusFrame;
    
    [self setUpData];
    
    [self setUpFrame];
}

//设置数据
- (void)setUpData{

    ZTStatus *status = _statusFrame.status;
    
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    
    //昵称
    if (status.user.vip) {
        
        _nameView.textColor = [UIColor redColor];
        
    }else{
    
        _nameView.textColor = [UIColor blackColor];
        
    }
    
    _nameView.text = status.user.name;
    
    
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    
    _vipView.image = [UIImage imageNamed:imageName];
    
    
    //时间
    _timeView.text = status.created_at;
    
    _timeView.textColor = [UIColor orangeColor];
    
    
    //来源
    _sourceView.text = status.source;
    
    
    //正文
    _textView.attributedText = status.attributedText;
//    _textView.text = status.text;
    
    //配图
    _photosView.pic_urls = status.pic_urls;
    
}

//设置Frame
- (void)setUpFrame{

    _iconView.frame = _statusFrame.originalIconFrame;
    
    _nameView.frame = _statusFrame.originalNameFrame;
    
    if (_statusFrame.status.user.vip) {
        
        _vipView.hidden = NO;
        
        _vipView.frame = _statusFrame.originalVipFrame;
        
    }else{
    
        _vipView.hidden = YES;
        
    }
    
    //时间会改变，“刚刚”和“具体分钟”显示的长度不一样，set方法在前执行没法控制，需要在get的时候重新算一下
    ZTStatus *status = _statusFrame.status;
    
    CGFloat timeX =  _nameView.frame.origin.x;
    
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + ZTStatusCellMargin;
    
    CGSize timeSize = [status.created_at sizeWithFont:ZTTimeFont];
    
    _timeView.frame = (CGRect){{timeX, timeY}, timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + ZTStatusCellMargin;
    
    CGFloat sourceY = timeY;
    
    CGSize sourceSize = [status.source sizeWithFont:ZTSourceFont];
    
    _sourceView.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
//    _timeView.frame = _statusFrame.originalTimeFrame;
//    
//    _sourceView.frame = _statusFrame.originalSourceFrame;
    
    _textView.frame = _statusFrame.originalTextFrame;
    
    _photosView.frame = _statusFrame.originalPhotosFrame;
}

@end




