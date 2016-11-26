//
//  ZTOneViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTOneViewController.h"

@interface ZTOneViewController ()

@end

@implementation ZTOneViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //去掉tableview分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}
@end
