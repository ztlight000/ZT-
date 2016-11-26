//
//  HZTEmotionListView.m
//  ZT微博
//
//  Created by 张涛 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "ZTEmotionListView.h"
#import "ZTEmotionPageView.h"

@interface ZTEmotionListView() <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation ZTEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 当只有1页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

// 根据emotions，创建对应个数的表情
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 删除之前的控件,否则最近表情会创建出多页
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + ZTEmotionPageSize - 1) / ZTEmotionPageSize;
    
    // 1.设置页数
    self.pageControl.numberOfPages = count;
//    self.pageControl.numberOfPages = count > 1? count : 0;
    
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i<count; i++) {
        ZTEmotionPageView *pageView = [[ZTEmotionPageView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * ZTEmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= ZTEmotionPageSize) { // 这一页足够20个
            range.length = ZTEmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    // 1页20个
    // 总共55个
    // 第0页：20个
    // 第1页：20个
    // 第2页：15个
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        ZTEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
