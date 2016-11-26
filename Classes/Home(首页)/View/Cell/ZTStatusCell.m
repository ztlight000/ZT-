//
//  ZTStatusCell.m
//  ZT微博
//
//  Created by zywx on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatusCell.h"

#import "ZTOriginalView.h"
#import "ZTRetweetView.h"
#import "ZTStatusToolBar.h"


@interface ZTStatusCell (){

}

@property (nonatomic, weak) ZTOriginalView *originalView;

@property (nonatomic, weak) ZTRetweetView *retweetView;

@property (nonatomic, weak) ZTStatusToolBar *statusToolBar;


@end

@implementation ZTStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
}

- (void)setUpAllChildView{

    ZTOriginalView *originalView = [[ZTOriginalView alloc] init];
    
    [self addSubview:originalView];
    
    _originalView = originalView;
    
    
    ZTRetweetView *retweetView = [[ZTRetweetView alloc] init];
    
    [self addSubview:retweetView];
    
    _retweetView = retweetView;
    
    
    ZTStatusToolBar *statusToolBar = [[ZTStatusToolBar alloc] init];
    
    [self addSubview:statusToolBar];
    
    _statusToolBar = statusToolBar;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *ID = @"cell";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;

}

- (void)setStatusFrame:(ZTStatusFrame *)statusFrame{

    _statusFrame = statusFrame;
    
    //设置原创微博的Frame
    _originalView.frame = statusFrame.originalViewFrame;
    
    _originalView.statusFrame = statusFrame;
    
    
    //设置转发微博的Frame
    _retweetView.frame = statusFrame.retweetViewFrame;
    
    _retweetView.statusFrame = statusFrame;
    
    
    //设置工具条的Frame
    _statusToolBar.frame = statusFrame.toolBarFrame;
    
    _statusToolBar.status = statusFrame.status;
    
}



@end
