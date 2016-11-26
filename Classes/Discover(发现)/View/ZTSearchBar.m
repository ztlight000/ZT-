//
//  ZTSearchBar.m
//  ZT微博
//
//  Created by zywx on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTSearchBar.h"

@implementation ZTSearchBar

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        
//        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        //创建一个内容可拉伸，而边角不拉伸的图片
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        imageView.width += 10;
        
        imageView.contentMode = UIViewContentModeCenter;
        
        self.leftView = imageView;
        
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}
@end
