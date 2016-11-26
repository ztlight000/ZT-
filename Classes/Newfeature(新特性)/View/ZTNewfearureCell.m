//
//  ZTNewfearureCell.m
//  ZT微博
//
//  Created by 张涛 on 16/3/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTNewfearureCell.h"
#import "ZTTabBarController.h"
@interface ZTNewfearureCell ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *startButton;

@property (nonatomic, weak) UIButton *shareButton;

@end

@implementation ZTNewfearureCell

- (UIButton *)startButton{

    if (_startButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
        [btn sizeToFit];

        [self addSubview:btn];
        
        _startButton = btn;

    }
    
    return _startButton;
}

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
        
    }
    return _shareButton;
}


- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        [self.contentView addSubview:imageV];
        
    }
    
    return _imageView;
}

//布局子控件的frame
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.75);
    
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.85);

}

- (void)setImage:(UIImage *)image{

    _image = image;
    
    self.imageView.image = image;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{

    if (indexPath.row < count - 1) {
        
        self.startButton.hidden = YES;
        
        self.shareButton.hidden = YES;
    
    }else{
    
        self.startButton.hidden = NO;
        
        self.shareButton.hidden = NO;
    
    }
}

// 点击开始微博的时候调用
- (void)start
{
    // 进入tabBarVc
    ZTTabBarController *tabBarVc = [[ZTTabBarController alloc] init];
    
    // 切换根控制器:可以直接把之前的根控制器清空
    ZTKeyWindow.rootViewController = tabBarVc;
    
}


@end




