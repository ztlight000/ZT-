//
//  ZTPhotoView.m
//  ZT微博
//
//  Created by 张涛 on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTPhotoView.h"
#import "UIImageView+WebCache.h"
#import "ZTPhoto.h"

@interface ZTPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation ZTPhotoView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.clipsToBounds = YES;
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        [self addSubview:gifView];
        
        _gifView = gifView;
        
    }
    
    return self;

}

- (void)setPhoto:(ZTPhoto *)photo{

    _photo = photo;
    
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    
    if ([urlStr hasSuffix:@".gif"]) {
        
        self.gifView.hidden = NO;
        
    }else{
    
        self.gifView.hidden = YES;
    
    }

}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    
    self.gifView.y = self.height - self.gifView.height;

}

@end
