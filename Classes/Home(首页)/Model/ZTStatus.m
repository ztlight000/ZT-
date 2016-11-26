//
//  ZTStatus.m
//  ZT微博
//
//  Created by zywx on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatus.h"
#import "ZTPhoto.h"
#import "NSDate+MJ.h"
#import "ZTTextPart.h"
#import "ZTSpecial.h"
#import "RegexKitLite.h"
#import "ZTEmotionTool.h"
#import "ZTEmotion.h"

@implementation ZTStatus

// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray{

    return @{@"pic_urls":[ZTPhoto class]};

}

/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        ZTTextPart *part = [[ZTTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        ZTTextPart *part = [[ZTTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(ZTTextPart *part1, ZTTextPart *part2) {
        // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        // 返回NSOrderedSame:两个一样大
        // NSOrderedAscending(升序):part2>part1
        // NSOrderedDescending(降序):part1>part2
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接每一段文字
    for (ZTTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            NSString *name = [ZTEmotionTool emotionWithChs:part.text].png;
            if (name) { // 能找到对应的图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.special) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                                                       }];
            
            // 创建特殊对象
            ZTSpecial *s = [[ZTSpecial alloc] init];
            s.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            [specials addObject:s];
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    
    return attributedText;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    // 利用text生成attributedText
    self.attributedText = [self attributedTextWithText:text];
}

- (void)setRetweeted_status:(ZTStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status.user.name, retweeted_status.text];
    
    self.retweetedAttributedText = [self attributedTextWithText:retweetContent];
    
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];

}


/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */
- (NSString *)created_at{

    NSLog(@"%@",_created_at);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    
    //必须设置，否则真机无法解析，跟操作系统语言环境有关
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];

    NSDate *created_at = [formatter dateFromString:_created_at];
    
    if ([created_at isThisYear]) {//是今年
        
        if ([created_at isToday]) {//今天
            
            NSDateComponents *cmp = [created_at deltaWithNow];
            
            if (cmp.hour >= 1) {
                
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
                
            }else if (cmp.minute > 1){
            
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
                
            }else{
            
                return @"刚刚";
                
            }
            
            
        }else if ([created_at isYesterday]){ // 昨天
            
            formatter.dateFormat = @"昨天 HH:mm";
            
            return  [formatter stringFromDate:created_at];
            
        }else{ // 前天以前
            
            formatter.dateFormat = @"MM-dd HH:mm";
            
            return  [formatter stringFromDate:created_at];
            
        }

        
        
    }else{//不是今年
    
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [formatter stringFromDate:created_at];
        
    }
    
    return _created_at;
    
}

- (void)setSource:(NSString *)source{

    NSRange range = [source rangeOfString:@">"];
    
    source = [source substringFromIndex:range.location + range.length];
    
    range = [source rangeOfString:@"<"];
    
    source = [source substringToIndex:range.location];
    
    source = [NSString stringWithFormat:@"来自%@",source];

    _source = source;

}


@end






