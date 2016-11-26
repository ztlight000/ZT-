//
//  ZTGroupItem.h
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTGroupItem : NSObject

/**
 *  一组有多少个cell（ZTSettingItem）
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *headerTitle;

/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footerTitle;


@end
