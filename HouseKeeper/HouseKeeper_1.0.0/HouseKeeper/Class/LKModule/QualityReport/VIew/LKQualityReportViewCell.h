//
//  LKQualityReportViewCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

@interface LKQualityReportViewCell : LKBaseTableViewCell
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;
@end
