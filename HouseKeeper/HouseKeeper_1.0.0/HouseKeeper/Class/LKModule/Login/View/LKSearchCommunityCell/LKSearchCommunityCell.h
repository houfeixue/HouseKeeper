//
//  LKSearchCommunityCell.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

@class LKSearchCommunityModel;

typedef void(^LKSearchCommunityCellSelected)(LKSearchCommunityModel *communityModel);

@interface LKSearchCommunityCell : LKBaseTableViewCell
@property (nonatomic, strong) LKSearchCommunityModel *communityModel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *communityNameLabel;
@property (nonatomic, copy) LKSearchCommunityCellSelected selectBtnChangeStatus;
+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;

@end
