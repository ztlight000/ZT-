//
//  ZTNewfearureCell.h
//  ZT微博
//
//  Created by 张涛 on 16/3/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTNewfearureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
