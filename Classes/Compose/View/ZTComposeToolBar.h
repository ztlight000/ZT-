//
//  ZTComposeToolBar.h
//  ZT微博
//
//  Created by 张涛 on 16/3/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZTComposeToolbarButtonTypeCamera, // 拍照
    ZTComposeToolbarButtonTypePicture, // 相册
    ZTComposeToolbarButtonTypeMention, // @
    ZTComposeToolbarButtonTypeTrend, // #
    ZTComposeToolbarButtonTypeEmotion // 表情
} ZTComposeToolbarButtonType;


@class ZTComposeToolBar;

@protocol ZTComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolbar:(ZTComposeToolBar *)toolbar didClickButton:(ZTComposeToolbarButtonType)buttonType;

@end

@interface ZTComposeToolBar : UIView

@property (nonatomic, weak) id<ZTComposeToolBarDelegate> delegate;

@property (nonatomic, assign) BOOL showKeyboardButton;

@end
