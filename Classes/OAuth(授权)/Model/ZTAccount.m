//
//  ZTAccount.m
//  ZT微博
//
//  Created by zywx on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTAccount.h"
#import "MJExtension.h"

#define ZTAccountTokenKey @"token"
#define ZTUidKey @"uid"
#define ZTExpires_inKey @"exoires"
#define ZTExpires_dateKey @"date"
#define ZTNameKey @"name"

@implementation ZTAccount
// 底层便利当前的类的所有属性，一个一个归档和接档
MJCodingImplementation
+ (instancetype)accountWithDict:(NSDictionary *)dict{

    ZTAccount *account = [[ZTAccount alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in{

    _expires_in = expires_in;
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
    
}

//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    
//    [aCoder encodeObject:_access_token forKey:ZTAccountTokenKey];
//    
//    [aCoder encodeObject:_uid forKey:ZTUidKey];
//    
//    [aCoder encodeObject:_expires_in forKey:ZTExpires_inKey];
//    
//    [aCoder encodeObject:_expires_date forKey:ZTExpires_dateKey];
//    
//    [aCoder encodeObject:_name forKey:ZTNameKey];
//    
//}
//
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        
//        _access_token = [aDecoder decodeObjectForKey:ZTAccountTokenKey];
//        
//        _uid = [aDecoder decodeObjectForKey:ZTUidKey];
//        
//        _expires_in = [aDecoder decodeObjectForKey:ZTExpires_inKey];
//        
//        _expires_date = [aDecoder decodeObjectForKey:ZTExpires_dateKey];
//        
//        _name = [aDecoder decodeObjectForKey:ZTNameKey];
//
//    }
//    
//    return self;
//}

@end
