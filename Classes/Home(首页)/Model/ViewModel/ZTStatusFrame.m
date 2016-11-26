//
//  ZTStatusFrame.m
//  ZT微博
//
//  Created by zywx on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTStatusFrame.h"
#import "ZTStatus.h"
#import "ZTUser.h"

@implementation ZTStatusFrame


- (void)setStatus:(ZTStatus *)status{

    _status = status;
    
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (_status.retweeted_status) {
        
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    CGFloat toolBarX = 0;
    
    CGFloat toolBarW = ZTScreenW;
    
    CGFloat toolBarH = 35;
    
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //计算cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

- (void)setUpOriginalViewFrame{

    //头像
    CGFloat iconX = ZTStatusCellMargin;
    
    CGFloat iconY = iconX;
    
    CGFloat iconWH = 35;
    
    _originalIconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + ZTStatusCellMargin;
    
    CGFloat nameY = iconY;
    
    CGSize nameSize = [_status.user.name sizeWithFont:ZTNameFont];
    
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (_status.user.vip) {
        
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + ZTStatusCellMargin;
        
        CGFloat vipY = nameY;
        
        CGFloat vipWH = 14;
        
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
//    //时间
//    CGFloat timeX = nameX;
//    
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + ZTStatusCellMargin;
//    
//    CGSize timeSize = [_status.created_at sizeWithFont:ZTTimeFont];
//    
//    _originalTimeFrame = (CGRect){{timeX, timeY}, timeSize};
//    
//    //来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + ZTStatusCellMargin;
//    
//    CGFloat sourceY = timeY;
//    
//    CGSize sourceSize = [_status.source sizeWithFont:ZTSourceFont];
//    
//    _originalSourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //正文
    CGFloat textX = iconX;
    
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + ZTStatusCellMargin;
    
    CGFloat textW = ZTScreenW - ZTStatusCellMargin * 2;
    
//    CGSize textSize = [_status.text sizeWithFont:ZTTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    CGSize textSize = [_status.attributedText boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    _originalTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + ZTStatusCellMargin;
    
    //配图
    if (_status.pic_urls.count) {
        
        CGFloat photosX = ZTStatusCellMargin;
        
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + ZTStatusCellMargin;
        
        CGSize photosSizt = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX, photosY}, photosSizt};
        
        originalH = CGRectGetMaxY(_originalPhotosFrame) + ZTStatusCellMargin;
        
    }
    
    //原创微博Frame
    CGFloat originalX = 0;
    
    CGFloat originalY = 10;
    
    CGFloat originalW = ZTScreenW;

    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(NSInteger)count{

    int cols = count == 4? 2 : 3;
    
    int rols = (count - 1) / cols + 1;
    
    CGFloat photoWH = 70;
    
    CGFloat w = cols * (photoWH + ZTStatusCellMargin);
    
    CGFloat h = rols * (photoWH + ZTStatusCellMargin);
    
    return CGSizeMake(w, h);
    
}

- (void)setUpRetweetViewFrame{

    //昵称
    CGFloat nameX = ZTStatusCellMargin;
    
    CGFloat nameY = nameX;
    
    CGSize nameSize = [_status.retweetName sizeWithFont:ZTNameFont];
    
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX = nameX;
    
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + ZTStatusCellMargin;
    
    CGFloat textW = ZTScreenW - ZTStatusCellMargin * 2;
    
//    CGSize textSize = [_status.retweeted_status.text sizeWithFont:ZTTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    
    CGSize textSize = [_status.attributedText boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    _retweetTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + ZTStatusCellMargin;
    
    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = ZTStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + ZTStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + ZTStatusCellMargin;
    }
    
    //转发微博Frame
    CGFloat retweetX = 0;
    
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    
    CGFloat retweetW = ZTScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}


@end
