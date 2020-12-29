//
//  LKQualityDetailModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityDetailModel.h"

@implementation LKQualityDetailModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items":[LKQualityDetailListModel class]};
}
@end

@implementation LKQualityDetailListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"images":[LKQualityDetailImageInfoModel class]};
}
@end

@implementation LKQualityDetailImageInfoModel

@end
