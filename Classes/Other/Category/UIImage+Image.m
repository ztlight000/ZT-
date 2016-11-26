//
//  UIImage+Image.m
//  ZT微博
//
//  Created by 张涛 on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)


+ (instancetype)imageWithOriginalName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
