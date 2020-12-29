//
//  LKCheckSearchCommunityCell.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/22.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCheckSearchCommunityCell.h"
#import "LKSearchCommunityListModel.h"

@implementation LKCheckSearchCommunityCell

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKCheckSearchCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKCheckSearchCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)_setupViews {
    [super _setupViews];
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kAdaptiveValue(50));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).inset(1);
    }];
    [self.contentView addSubview:self.communityNameLabel];
    [self.communityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.height.equalTo(self.contentView.mas_height);
        make.top.mas_equalTo(0);
        make.right.equalTo(self.deleteBtn.mas_left);
    }];
    
    self.separatorView.hidden = NO;
    [self.contentView bringSubviewToFront:self.separatorView];
    [self.separatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(kLineHeight));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
}

- (void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath {
    LKSearchCommunityModel *checkCommunityModel = (LKSearchCommunityModel *)data;
    self.checkCommunityModel = checkCommunityModel;
    self.communityNameLabel.text = checkCommunityModel.name;
}
- (void)deleteButtonClick {
    if (self.deleteBtnClick != nil) {
        self.deleteBtnClick(self.checkCommunityModel);
    }
}
- (UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"app_icon_delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
- (UILabel *)communityNameLabel {
    if (_communityNameLabel == nil) {
        _communityNameLabel = [[UILabel alloc] init];
        _communityNameLabel.font = LK_15font;
        _communityNameLabel.textColor = LKLightGrayColor;
    }
    return _communityNameLabel;
}
@end
