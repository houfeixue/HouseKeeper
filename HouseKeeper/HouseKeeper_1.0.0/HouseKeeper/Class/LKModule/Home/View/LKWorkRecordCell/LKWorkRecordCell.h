//
//  LKWorkRecordCell.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"
#import "LKWorkRecordListModel.h"

@interface LKWorkRecordCell : LKBaseTableViewCell

@property (nonatomic, strong) LKWorkRecordListModel *listModel;

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;

- (void)bindData:(LKWorkRecordListModel *)listModel indexPath:(NSIndexPath *)indexPath;
@end
