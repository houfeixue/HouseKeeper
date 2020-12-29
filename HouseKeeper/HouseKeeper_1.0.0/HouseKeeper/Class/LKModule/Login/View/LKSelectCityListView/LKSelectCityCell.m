//
//  LKSelectCityCell.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectCityCell.h"

@implementation LKSelectCityCell

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKSelectCityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKSelectCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)_setupViews {
    [super _setupViews];
    [self.contentView addSubview:self.cityNameLabel];

    [self.cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

//lazy
- (UILabel *)cityNameLabel {
    if (_cityNameLabel == nil) {
        _cityNameLabel = [[UILabel alloc]init];
        _cityNameLabel.font = LK_15font;
        _cityNameLabel.textColor = LKLightGrayColor;
        _cityNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cityNameLabel;
}

@end
