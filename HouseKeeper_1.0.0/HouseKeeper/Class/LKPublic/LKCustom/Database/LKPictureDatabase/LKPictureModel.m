//
//  LKPictureModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureModel.h"

@implementation LKPictureModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"des":@"desc",@"picName":@"url"};
}
MJExtensionCodingImplementation


@end
