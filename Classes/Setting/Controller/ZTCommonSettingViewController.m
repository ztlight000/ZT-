//
//  ZTCommonSettingViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTCommonSettingViewController.h"
#import "ZTBaseSetting.h"
#import "ZTFontSizeViewController.h"
#import "ZTFontSizeTool.h"

#define ZTFontSizeChangeNote @"fontSiziChange"

@interface ZTCommonSettingViewController ()

@property (nonatomic, weak) ZTSettingItem *fontSize;

@end

@implementation ZTCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加第0组
    [self setUpGroup0];
    
    // 添加第1组
    [self setUpGroup1];
    
    // 添加第2组
    [self setUpGroup2];
    
    // 添加第3组
    [self setUpGroup3];
    
    // 添加第4组
    [self setUpGroup4];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange) name:ZTFontSizeChangeNote object:nil];
}

- (void)fontSizeChange{
    
    //修改模型
    _fontSize.subTitle = [ZTFontSizeTool fontSize];
    
    //刷新界面
    [self.tableView reloadData];
    
}

- (void)setUpGroup0{
    
    // 阅读模式
    ZTSettingItem *read = [ZTSettingItem itemWithTitle:@"阅读模式"];
    
    read.subTitle = @"有图模式";
    
    
    // 字体大小
    ZTSettingItem *fontSize = [ZTSettingItem itemWithTitle:@"字体大小"];
    
    _fontSize = fontSize;
    
    NSString *fontSizeStr =  [ZTFontSizeTool fontSize];
    
    if (fontSizeStr == nil) {
        
        fontSizeStr = @"中";
        
        [ZTFontSizeTool saveFontSize:fontSizeStr];
        
    }
    
    fontSize.subTitle = fontSizeStr;
    
    fontSize.destVcClass = [ZTFontSizeViewController class];
    
    
    // 显示备注
    ZTSwitchItem *remark = [ZTSwitchItem itemWithTitle:@"显示备注"];
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[read,fontSize,remark];
    
    [self.groups addObject:group];
    
}

- (void)setUpGroup1{
    
    // 图片质量
    ZTSettingItem *quality = [ZTSettingItem itemWithTitle:@"图片质量" ];
    
//    quality.descVc = [IWQualityViewController class];
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[quality];
    
    [self.groups addObject:group];
    
}
- (void)setUpGroup2{
    
    // 声音
    ZTSwitchItem *sound = [ZTSwitchItem itemWithTitle:@"声音" ];
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[sound];
    
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    ZTSettingItem *language = [ZTSettingItem itemWithTitle:@"多语言环境"];
    
    language.subTitle = @"跟随系统";
    
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[language];
    
    [self.groups addObject:group];
}

- (void)setUpGroup4
{
    // 清空图片缓存
    ZTArrowItem *clearImage = [ZTArrowItem itemWithTitle:@"清空图片缓存"];
//    CGFloat fileSize = [SDWebImageManager sharedManager].imageCache.getSize / 1024.0;
//    clearImage.subTitle = [NSString stringWithFormat:@"%.fKB",fileSize];
//    if (fileSize > 1024) {
//        fileSize =   fileSize / 1024.0;
//        clearImage.subTitle = [NSString stringWithFormat:@"%.1fM",fileSize];
//    }
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    
//    CGFloat size =  [self sizeWithFile:filePath];
//    NSLog(@"%f",size);
//    clearImage.option = ^{
//        
//        [[SDWebImageManager sharedManager].imageCache clearDisk];
//        clearImage.subTitle = nil;
//        [self.tableView reloadData];
//        
//        //     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//        //      NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//        //
//        //        [self removeFile:filePath];
//        
//    };
    ZTGroupItem *group = [[ZTGroupItem alloc] init];
    
    group.items = @[clearImage];
    
    [self.groups addObject:group];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
