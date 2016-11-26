//
//  ZTStatusCell.h
//  ZT微博
//
//  Created by zywx on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTStatusFrame.h"

@interface ZTStatusCell : UITableViewCell

@property (nonatomic, strong) ZTStatusFrame *statusFrame;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
