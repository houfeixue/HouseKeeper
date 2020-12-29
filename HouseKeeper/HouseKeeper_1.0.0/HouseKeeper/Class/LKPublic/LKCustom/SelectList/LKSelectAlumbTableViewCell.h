//
//  LKSelectAlumbTableViewCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/26.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

@interface LKSelectAlumbTableViewCell : LKBaseTableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;

@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIImageView * selectImage;

@end
