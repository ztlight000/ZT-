//
//  ZTBaseSettingViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTBaseSettingViewController.h"
#import "ZTGroupItem.h"
#import "ZTSettingItem.h"
#import "ZTBaseSettingCell.h"


@interface ZTBaseSettingViewController ()

@end

@implementation ZTBaseSettingViewController


- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        
        _groups = [NSMutableArray array];
        
    }
    
    return _groups;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZTGroupItem *groupItem = self.groups[section];
    
    return groupItem.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZTGroupItem *groupItem = self.groups[section];
    
    return groupItem.footerTitle;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    ZTGroupItem *groupItem = self.groups[section];
    
    return groupItem.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZTBaseSettingCell *cell = [ZTBaseSettingCell cellWithTableView:tableView];

    // 获取模型
    ZTGroupItem *groupItem = self.groups[indexPath.section];
    
    ZTSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
        
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中这一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取模型
    ZTGroupItem *groupItem = self.groups[indexPath.section];
    
    ZTSettingItem *item = groupItem.items[indexPath.row];
    
    if (item.option) { //有事情调用
        
        item.option((ZTCheakItem *)item);
        
        return;
    }
    
    if (item.destVcClass) {
        
        UIViewController *vc = [[item.destVcClass alloc] init];
        
        vc.title = item.title;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
