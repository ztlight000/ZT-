//
//  ZTFontSizeViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTFontSizeViewController.h"
#import "ZTBaseSetting.h"
#import "ZTFontSizeTool.h"

#define ZTFontSizeChangeNote @"fontSiziChange"

@interface ZTFontSizeViewController ()

@property (nonatomic, weak) ZTCheakItem *selCheakItem;

@end

@implementation ZTFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加第0组
    [self setUpGroup0];
    
}

- (void)setUpGroup0
{
    
    // 大
    ZTCheakItem *big = [ZTCheakItem itemWithTitle:@"大"];
    
    __weak typeof(self) vc = self;
    
    big.option = ^(ZTCheakItem *item){
        
        [vc selItem:big];
        
    };
    
    
    // 中
    ZTCheakItem *middle = [ZTCheakItem itemWithTitle:@"中"];
    
    middle.option = ^(ZTCheakItem *item){
        
        [vc selItem:middle];
        
    };
    
    _selCheakItem = middle;
    
    
    // 小
    ZTCheakItem *small = [ZTCheakItem itemWithTitle:@"小"];
    
    small.option = ^(ZTCheakItem *item){
        
        [vc selItem:small];
        
    };
    
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[big,middle,small];
    
    [self.groups addObject:group];
    
    // 默认选中item
    [self setUpSelItem:[ZTFontSizeTool fontSize]];
    
}

- (void)setUpSelItem:(NSString *)title{
    
    for (ZTGroupItem *group in self.groups) {
        
        for (ZTCheakItem *item in group.items) {
            
            if ( [item.title isEqualToString:title]) {
                
                [self selItem:item];
                
            }
        }
    }
}

- (void)selItem:(ZTCheakItem *)item
{
    _selCheakItem.cheak = NO;
    
    item.cheak = YES;
    
    _selCheakItem = item;
    
    [self.tableView reloadData];
    
    [ZTFontSizeTool saveFontSize:item.title];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ZTFontSizeChangeNote object:nil];
    
}


@end
