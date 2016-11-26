//
//  ZTRetweetView.m
//  ZT微博
//
//  Created by zywx on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTRetweetView.h"
#import "ZTStatusFrame.h"
#import "ZTStatus.h"
#import "ZTPhotosView.h"
#import "ZTStatusTextView.h"

@interface ZTRetweetView ()

//昵称
@property (nonatomic, weak) UILabel *nameView;

//正文
@property (nonatomic, weak) ZTStatusTextView *textView;
//@property (nonatomic, weak) UILabel *textView;

//配图
@property (nonatomic, weak) ZTPhotosView *photosView;

@end

@implementation ZTRetweetView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    
    return self;
    
}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    
    nameView.textColor = [UIColor blueColor];
    
    nameView.font = ZTNameFont;
    
    [self addSubview:nameView];
    
    _nameView = nameView;
    
    
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
    
    ZTStatus *status = statusFrame.status;
    
    //昵称
    _nameView.text = status.retweetName;
    
    _nameView.frame = _statusFrame.retweetNameFrame;
    
    
    //正文
    _textView.attributedText = status.retweeted_status.attributedText;
//    _textView.text = status.retweeted_status.text;
    
    _textView.frame = _statusFrame.retweetTextFrame;
    
    
    //配图
    _photosView.frame = _statusFrame.retweetPhotosFrame;
    
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
