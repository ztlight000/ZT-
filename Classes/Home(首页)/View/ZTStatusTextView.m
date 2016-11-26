//
//  ZTStatusTextView.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatusTextView.h"
#import "ZTSpecial.h"

#define ZTStatusTextViewCoverTag 999

@implementation ZTStatusTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 禁止滚动, 让文字完全显示出来
        self.scrollEnabled = NO;
    }
    return self;
}

- (void)setupSpecialRects{
    
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (ZTSpecial *special in specials) {
        self.selectedRange = special.range;
        // self.selectedRange --影响--> self.selectedTextRange
        // 获得选中范围的矩形框
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        
        for (UITextSelectionRect *selectionRect in selectionRects) {
            
            CGRect rect = selectionRect.rect;
            
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            
            [rects addObject:[NSValue valueWithCGRect:rect]];
            
        }
        
        special.rects = rects;
    }
    
}

//找出被触摸的特殊字符串
- (ZTSpecial *)touchingSpecialWithPoint:(CGPoint)point{

    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (ZTSpecial *special in specials) {
    
        for (NSValue *rectValue in special.rects) {
            
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) { // 点中了某个特殊字符串
                return special;
            }
        }
    }
    
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 触摸对象
    UITouch *touch = [touches anyObject];
    
    // 触摸点
    CGPoint point = [touch locationInView:self];
    
    //初始化矩形框
    [self setupSpecialRects];
    
    // 在被触摸的特殊字符串后面显示一段高亮的背景
    ZTSpecial *special = [self touchingSpecialWithPoint:point];
    
        for (NSValue *rectValue in special.rects) {
           
            UIView *cover = [[UIView alloc] init];
            cover.backgroundColor = [UIColor greenColor];
            cover.frame = rectValue.CGRectValue;
            cover.tag = ZTStatusTextViewCoverTag;
            cover.layer.cornerRadius = 5;
            [self insertSubview:cover atIndex:0];
        }
    
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//    return [super hitTest:point withEvent:event];
//
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    [self setupSpecialRects];

    ZTSpecial *special = [self touchingSpecialWithPoint:point];
    
    if (special) {
        return YES;
    }else {
        return NO;
    
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 去掉特殊字符串后面的高亮背景
    for (UIView *child in self.subviews) {
        if (child.tag == ZTStatusTextViewCoverTag) [child removeFromSuperview];
    }
}
@end
