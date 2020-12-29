//
//  LKSearchCommunityListModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchCommunityListModel.h"

@implementation LKSearchCommunityListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"communitys" : [LKSearchCommunityModel class]};
}
@end
@implementation LKSearchCommunityModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"communityId" : @"id"};
}
@end
