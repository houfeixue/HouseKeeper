//
//  LKUserInfoModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKUserInfoModel.h"

@implementation LKUserInfoModel
// NSCoding实现
MJExtensionCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userId": @"id"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"communities" : [LKUserInfoCommunityModel class]};
}
@end

@implementation LKUserInfoCommunityModel
// NSCoding实现
MJExtensionCodingImplementation
@end
