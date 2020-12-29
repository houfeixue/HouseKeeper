//
//  LKSearchCommunityListModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LKSearchCommunityModel;

@interface LKSearchCommunityListModel : NSObject
@property (nonatomic, copy) NSString *alpha;
@property (nonatomic, strong) NSArray<LKSearchCommunityModel *> *communitys;
@end

@interface LKSearchCommunityModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *alpha;
@property (nonatomic, assign) int communityId;

@property (nonatomic, assign) BOOL selected;
@end
