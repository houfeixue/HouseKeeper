//
//  LKAddWorkRecordBottomView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAddWorkRecordBottomView.h"

@interface LKAddWorkRecordBottomView()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LKAddWorkRecordBottomView


-(void)createUI {
    [super createUI];
    self.clipsToBounds = YES;
    [self addSubview:self.lineView];
    [self addSubview:self.editBtn];
    [self addSubview:self.deleteBtn];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kLineHeight);
        make.left.equalTo(self.deleteBtn.mas_right);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.deleteBtn.mas_width);
    }];
}

- (UIButton *)editBtn {
    if (_editBtn == nil) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"notes_icon_edit"] forState:UIControlStateNormal];
        _editBtn.titleLabel.font = LK_10font;
        [_editBtn setTitleColor:LKLightGrayColor forState:UIControlStateNormal];
        [_editBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -19, 0, 0) withImageEdgeInsets:UIEdgeInsetsMake(6, 19, 20, 0)];
    }
    return _editBtn;
}
- (UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"notes_icon_delete"] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = LK_10font;
        [_deleteBtn setTitleColor:LKLightGrayColor forState:UIControlStateNormal];
        [_deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(25, -19, 0, 0) withImageEdgeInsets:UIEdgeInsetsMake(6, 19, 20, 0)];
    }
    return _deleteBtn;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}
@end
