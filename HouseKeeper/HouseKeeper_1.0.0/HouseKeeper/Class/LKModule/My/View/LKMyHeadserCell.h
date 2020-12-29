//
//  LKMyHeadserCell.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

@interface LKMyHeadserCell : LKBaseTableViewCell

@property(nonatomic ,strong) UIImageView *picImageView;
@property(nonatomic ,strong) UILabel *titleLable;
@property(nonatomic ,strong) UIImageView *versionImageView;
@property(nonatomic ,strong) UILabel *rightLable;
@property(nonatomic ,strong) UIImageView *rightImageView;

@property(nonatomic ,strong) UIView *lineView;

-(void)fillCellWithDictionary:(NSDictionary *)dic;
@end
