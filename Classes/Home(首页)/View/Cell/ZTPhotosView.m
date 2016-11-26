//
//  ZTPhotosView.m
//  ZT微博
//
//  Created by zywx on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTPhotosView.h"
#import "UIImageView+WebCache.h"
#import "ZTPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "ZTPhotoView.h"

@implementation ZTPhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor redColor];

        // 添加9个子控件
        [self setUpAllChildView];
        
    }
    
    return self;

}

- (void)setUpAllChildView{

    for (int i = 0; i < 9; i++) {
        
        ZTPhotoView *imageView = [[ZTPhotoView alloc] init];
        
        imageView.tag = i;
        
        //添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
        
    }
    
}

- (void)tap:(UITapGestureRecognizer *)tap{

    UIImageView *tapView = tap.view;
    
    int i = 0;
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    
    // ZTPhoto -> MJPhoto
    for (ZTPhoto *photo in _pic_urls) {
        
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        MJPhoto *p = [[MJPhoto alloc] init];
        
        p.url = [NSURL URLWithString:urlStr];
        
        p.index = i;
        
        p.srcImageView = tapView;
        
        [arrM addObject:p];
        
        i++;
    }
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    
    // MJPhoto
    brower.photos = arrM;
    
    brower.currentPhotoIndex = tapView.tag;
    
    [brower show];

}

- (void)setPic_urls:(NSArray *)pic_urls{

    _pic_urls = pic_urls;
    
    NSInteger count = self.subviews.count;
    
    for (int i = 0; i < count; i++) {
        
        ZTPhotoView *imageView = self.subviews[i];
        
        if (i < pic_urls.count) {
            
            imageView.hidden = NO;
            
            //获取ZTPhoto模型
            ZTPhoto *photo = pic_urls[i];
            
            imageView.photo = photo;
            
        }else{
        
            imageView.hidden = YES;
            
        }
    }

}

// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
    
    
}


@end
