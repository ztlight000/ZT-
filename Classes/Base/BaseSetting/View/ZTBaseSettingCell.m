//
//  ZTBaseSettingCell.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTBaseSettingCell.h"

#import "ZTBaseSetting.h"
#import "ZTBadgeView.h"

@interface ZTBaseSettingCell ()

//箭头
@property (nonatomic, strong) UIImageView *arrowView;

//switch
@property (nonatomic, strong) UISwitch *switchView;

//check
@property (nonatomic, strong) UIImageView *cheakView;

//badge
@property (nonatomic, strong) ZTBadgeView *badgeView;

//label
@property (nonatomic, strong) UILabel *labelView;


@end


@implementation ZTBaseSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    ZTBaseSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    
    return cell;
    
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        
        _labelView = label;
        
        _labelView.textAlignment = NSTextAlignmentCenter;
        
        _labelView.textColor = [UIColor redColor];
        
    }
    
    return _labelView;
    
}

- (ZTBadgeView *)badgeView
{
    if (_badgeView == nil) {
        
        _badgeView = [[ZTBadgeView alloc] init];
        
    }
    
    return _badgeView;
    
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        
    }
    
    return _arrowView;
    
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        
        _switchView = [[UISwitch alloc] init];
        
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _switchView;
    
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
        
    }
    
    return _cheakView;
    
}

- (void)setItem:(ZTSettingItem *)item
{
    _item = item;
    
    // 设置数据
    [self setUpData];
    
    // 设置模型
    [self setUpRightView];
}

- (void)setUpData
{
    self.textLabel.text = _item.title;
    
    self.detailTextLabel.text = _item.subTitle;
    
    self.imageView.image = _item.image;
}

- (void)setUpRightView
{
    if ([_item isKindOfClass:[ZTArrowItem class]]) { // 箭头
        
        self.accessoryView = self.arrowView;
        
    }else if ([_item isKindOfClass:[ZTSwitchItem class]]){ // 开关
        
        self.accessoryView = self.switchView;
        
        ZTSwitchItem *switchItem = (ZTSwitchItem *)_item;
        
        self.switchView.on = switchItem.on;
        
    }else if ([_item isKindOfClass:[ZTCheakItem class]]){ // 打钩
        
        ZTCheakItem *badgeItem = (ZTCheakItem *)_item;
        
        if (badgeItem.cheak) {
            
            self.accessoryView = self.cheakView;
            
        }else{
            
            self.accessoryView = nil;
            
        }
    }else if ([_item isKindOfClass:[ZTBadgeItem class]]){
        
        ZTBadgeItem *badgeItem = (ZTBadgeItem *)_item;
        
        ZTBadgeView *badge = self.badgeView;
        
        self.accessoryView = badge;
        
        badge.badgeValue = badgeItem.badgeValue;
        
    }else if ([_item isKindOfClass:[ZTLabelItem class]]){
        
        ZTLabelItem *labelItem = (ZTLabelItem *)_item;
        
        UILabel *label = self.labelView;
        
        label.text = labelItem.text;
        
        [self addSubview:_labelView];
        
    }else{ // 没有
        
        self.accessoryView = nil;
        
        [_labelView removeFromSuperview];
        
        _labelView = nil;
    }
    
}

- (void)switchChange:(UISwitch *)switchView{


}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    self.labelView.frame = self.bounds;
}

@end
