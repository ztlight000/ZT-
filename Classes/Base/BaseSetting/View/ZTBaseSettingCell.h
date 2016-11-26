//
//  ZTBaseSettingCell.h
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTSettingItem;


@interface ZTBaseSettingCell : UITableViewCell

@property (nonatomic, strong) ZTSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
