//
//  LKSelectListViewCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LKSelectClassifyVIewCell : LKBaseTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;
@property(nonatomic,strong)UIImageView * picBorderView;

@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIImageView * selectImage;

@end
