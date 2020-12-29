//
//  LKCheckSearchCommunityCell.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/22.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

@class LKSearchCommunityModel;

typedef void(^LKSearchCommunityCellDeleteCommunity)(LKSearchCommunityModel *deleteCommunityModel);


@interface LKCheckSearchCommunityCell : LKBaseTableViewCell
@property (nonatomic, strong) LKSearchCommunityModel *checkCommunityModel;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *communityNameLabel;
@property (nonatomic, copy) LKSearchCommunityCellDeleteCommunity deleteBtnClick;
+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;
@end
