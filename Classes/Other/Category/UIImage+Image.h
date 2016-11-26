//
//  UIImage+Image.h
//  ZT微博
//
//  Created by 张涛 on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

//instancetype默认会识别当前是哪个类或对象调用，就会转换成对应的类的对象
//UIImage *

//加载最原始的图片
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
