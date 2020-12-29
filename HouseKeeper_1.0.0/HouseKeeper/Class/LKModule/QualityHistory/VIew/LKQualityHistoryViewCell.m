//
//  LKQualityHistoryViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityHistoryViewCell.h"

@implementation LKQualityHistoryViewCell

//重写view
- (void)_setupViews
{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.checkManLabel];
    [self.contentView addSubview:self.identityLabel];
    [self.contentView addSubview:self.scoreLabel];
    [self.contentView addSubview:self.detailBtn];
    [self.contentView addSubview:self.lookBtn];
    [self.contentView addSubview:self.lineView];

    [self.timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.height.equalTo(@(14));
        make.width.mas_greaterThanOrEqualTo(70);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.top.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.height.equalTo(@(20));
        make.right.equalTo(self.timeLabel.mas_left).offset(-5);

    }];
    
    [self.checkManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.width.equalTo(self.contentView).dividedBy(3);
        make.height.equalTo(@(40));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
    }];
    
    [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView).dividedBy(3);
        make.height.equalTo(@(40));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.width.equalTo(self.contentView).dividedBy(3);
        make.height.equalTo(@(40));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(16);
        make.width.equalTo(@(kScreen_Width/2));
        make.height.equalTo(@(42));
    }];
    
    [self.detailBtn borderForColor:LKF7Color borderWidth:1 borderType:UIBorderSideTypeTop|UIBorderSideTypeRight];
    
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(16);
        make.width.equalTo(@(kScreen_Width/2));
        make.height.equalTo(@(42));
    }];
    [self.lookBtn borderForColor:LKF7Color borderWidth:1 borderType:UIBorderSideTypeTop];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(10));
    }];
    
}


-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    LKQualityHistoryModel *model = (LKQualityHistoryModel *)data;
    if ([LKCustomTool isBlankString:model.createTime] == NO) {
        NSArray *array = [model.createTime componentsSeparatedByString:@" "];
        if (array.count > 0) {
            self.timeLabel.text = [array objectAtIndex:0];
        }
    }
    self.nameLabel.attributedText = [NSString getAttributeStringWithimage:[UIImage imageNamed:@"line"] imageBounds:CGRectMake(0, 0, 4, 14) withLabelText:[NSString stringWithFormat:@"  %@",model.regionName] font:LK_16font textColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1/1.0]];
    
    self.checkManLabel.attributedText = [NSString getAttributeStringWithLabelText:@"检查人\n" font:LK_12font textColor:LKLightGrayColor changeText:model.realName changeFont:LK_16font changeColor:[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1/1.0]];
    
    self.identityLabel.attributedText = [NSString getAttributeStringWithLabelText:@"身份\n" font:LK_12font textColor:LKLightGrayColor changeText:model.identityName changeFont:LK_16font changeColor:[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1/1.0]];
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",model.scort]];
    self.scoreLabel.attributedText = [NSString getAttributeStringWithLabelText:@"得分\n" font:LK_12font textColor:LKLightGrayColor changeText:[NSString stringWithFormat:@"%@分",[decimalNumber stringValue]] changeFont:LK_16font changeColor:LKLightRedColor];
}


//lazy
-(UILabel *)nameLabel{
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc]init];
//        _nameLabel.text = @"XX小区";
//        _nameLabel.font = LK_16font;
//        _nameLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1/1.0];
    }
    return _nameLabel;
    
}

-(UILabel *)timeLabel{
    if(_timeLabel == nil){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2018-06-13";
        _timeLabel.font =  LK_12font;
        _timeLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1/1.0];

    }
    return _timeLabel;
    
}

-(UILabel *)checkManLabel{
    if(_checkManLabel == nil){
        _checkManLabel = [[UILabel alloc]init];
        _checkManLabel.font =  LK_12font;
        _checkManLabel.numberOfLines = 2;
    }
    return _checkManLabel;
    
}
-(UILabel *)identityLabel{
    if(_identityLabel == nil){
        _identityLabel = [[UILabel alloc]init];
        _identityLabel.font =  LK_12font;
        _identityLabel.numberOfLines = 2;
        _identityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _identityLabel;
}
-(UILabel *)scoreLabel{
    if(_scoreLabel == nil){
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font =  LK_12font;
        _scoreLabel.numberOfLines = 2;
        _scoreLabel.textAlignment = NSTextAlignmentRight;
    }
    return _scoreLabel;
}
- (UIButton *)detailBtn {
    if (_detailBtn == nil) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"查看明细" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:LKCrownColor forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = LK_17font;
        _detailBtn.backgroundColor = [UIColor whiteColor];
        @weakify(self)
        [[_detailBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.qualityHistoryCellClick) {
                self.qualityHistoryCellClick(@"detail");
            }
        }];
    }
    return _detailBtn;
}

-(UIButton *)lookBtn
{
    if (_lookBtn == nil) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookBtn setTitle:@"查看报告" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:LKCrownColor forState:UIControlStateNormal];
        _lookBtn.titleLabel.font = LK_17font;
        _lookBtn.backgroundColor = [UIColor whiteColor];
//        @weakify(self)
//        [[[_lookBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(id x) {
//            @strongify(self);
//            if (self.qualityHistoryCellClick) {
//                self.qualityHistoryCellClick(@"look");
//            }
//        }];
    }
    return _lookBtn;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0];
    }
    return _lineView;
}

@end
