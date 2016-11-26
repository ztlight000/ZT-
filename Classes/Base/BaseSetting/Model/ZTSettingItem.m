//
//  ZTSettingItem.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTSettingItem.h"

@implementation ZTSettingItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image{

    ZTSettingItem *item = [[self alloc] init];
    
    item.image = image;
    
    item.subTitle = subTitle;
    
    item.title = title;
    
    return item;

}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image{
    
    ZTSettingItem *item = [self itemWithTitle:title subTitle:nil image:image];
    
    return item;

}

+ (instancetype)itemWithTitle:(NSString *)title{
    
    ZTSettingItem *item = [self itemWithTitle:title subTitle:nil image:nil];
    
    return item;
}




@end
