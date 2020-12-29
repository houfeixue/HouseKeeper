//
//  LKSearchCommunityCell.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchCommunityCell.h"
#import "LKSearchCommunityListModel.h"

@interface LKSearchCommunityCell()

@end

@implementation LKSearchCommunityCell

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKSearchCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKSearchCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)_setupViews {
    [super _setupViews];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.height.mas_equalTo(kAdaptiveValue(49));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [self.contentView addSubview:self.communityNameLabel];
    [self.communityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right);
        make.height.equalTo(self.contentView.mas_height);
        make.top.mas_equalTo(0);
        make.right.equalTo(self.contentView.mas_right).inset(kAdaptiveValue(LKLeftMargin));
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
    LKSearchCommunityModel *communityModel = (LKSearchCommunityModel *)data;
    self.communityModel = communityModel;
    self.communityNameLabel.text = communityModel.name;
    self.selectBtn.selected = communityModel.selected;
}
- (void)selectBtnClick {
    self.selectBtn.selected = !self.selectBtn.selected;
    if (self.selectBtnChangeStatus != nil) {
        self.communityModel.selected = self.selectBtn.selected;
        self.selectBtnChangeStatus(self.communityModel);
    }
}
- (UIButton *)selectBtn {
    if (_selectBtn == nil) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"app_icon_default.png"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"app_icon_selected.png"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _selectBtn;
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
