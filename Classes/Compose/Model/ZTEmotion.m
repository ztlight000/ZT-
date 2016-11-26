//
//  ZTEmotion.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "ZTEmotion.h"
#import "MJExtension.h"

@interface ZTEmotion() <NSCoding>

@end

@implementation ZTEmotion

MJCodingImplementation
/**
 *  从文件中解析对象时调用
 */
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//    }
//    return self;
//}
//
///**
// *  将对象写入文件的时候调用
// */
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//}

/**
 *  常用来比较两个HWEmotion对象是否一样
 *
 *  @param other 另外一个HWEmotion对象
 *
 *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
 */
- (BOOL)isEqual:(ZTEmotion *)other
{
    //    if (self == other) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    
    //    HWLog(@"%@--isEqual---%@", self.chs, other.chs);
    
    //    NSString *str1 = @"jack";
    //    NSString *str2 = [NSString stringWithFormat:@"jack"];
    //
    //    str1 == str2 // no
    //    [str1 isEqual:str2]; // NO
    //    [str1 isEqualToString:str2] // YES
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}


@end
