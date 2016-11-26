//
//  ZTFontSizeTool.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTFontSizeTool.h"

#define ZTUserDefaults [NSUserDefaults standardUserDefaults]

#define ZTFontSizeKey @"fontSizeKey"

@implementation ZTFontSizeTool


+ (void)saveFontSize:(NSString *)fontSize{
    
    [ZTUserDefaults setObject:fontSize forKey:ZTFontSizeKey];
    
    [ZTUserDefaults synchronize];

}

+ (NSString *)fontSize{

    return [ZTUserDefaults objectForKey:ZTFontSizeKey];

}


@end
