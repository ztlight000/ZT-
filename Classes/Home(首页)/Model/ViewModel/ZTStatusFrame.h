//
//  ZTStatusFrame.h
//  ZT微博
//
//  Created by zywx on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTStatus;

@interface ZTStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) ZTStatus *status;


//原创微博Frame
@property (nonatomic, assign) CGRect originalViewFrame;

//**********原创微博子控件Frame*********//

//头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

//昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

//vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

//时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

//来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

//正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

//配图Frame
@property (nonatomic, assign) CGRect originalPhotosFrame;


//转发微博Frame
@property (nonatomic, assign) CGRect retweetViewFrame;

//**********转发微博子控件Frame*********//

//昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

//正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

//转发配图Frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;



//工具条Frame
@property (nonatomic, assign) CGRect toolBarFrame;

//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
