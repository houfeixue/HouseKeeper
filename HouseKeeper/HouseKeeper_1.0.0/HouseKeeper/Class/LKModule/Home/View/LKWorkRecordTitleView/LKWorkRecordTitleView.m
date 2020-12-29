//
//  LKWorkRecordTitleView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKWorkRecordTitleView.h"

@interface LKWorkRecordTitleView()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, strong) NSDate *minimumDate;

@property (nonatomic, strong) NSDateFormatter *compareDateFormatter;

@end

@implementation LKWorkRecordTitleView

- (void)createUI {
    [super createUI];
    NSDate *nowDate = [NSDate date];
    self.minimumDate = [NSDate getNewDateWithIntervalYear:-1 intervalMonth:0 intervalDay:0 currentDate:nowDate];
    self.maximumDate = nowDate;
    self.currentSelectDate = nowDate;

    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.titleLabel];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(kNavBarHeight);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.height.mas_equalTo(kNavBarHeight);
        make.top.mas_equalTo(0);
        make.left.equalTo(self.titleLabel.mas_right);
    }];
    self.dateFormatter.dateFormat = @"MM月dd日";
    self.titleLabel.text = [self.dateFormatter stringFromDate:_currentSelectDate];
}

- (void)setCurrentSelectDate:(NSDate *)currentSelectDate {
    _currentSelectDate = currentSelectDate;
    if ([_currentSelectDate isThisYear:[NSDate date]]) {
        self.dateFormatter.dateFormat = @"MM月dd日";
    }else {
        self.dateFormatter.dateFormat = @"YY年MM月dd日";
    }
    NSString *tempCurrentDate = [self.compareDateFormatter stringFromDate:_currentSelectDate];
    NSString *earlierDate = [self.compareDateFormatter stringFromDate:[_currentSelectDate earlierDate:self.minimumDate]];
    NSString *laterDate = [self.compareDateFormatter stringFromDate:[_currentSelectDate laterDate:self.maximumDate]];
    
    if ([earlierDate isEqualToString:tempCurrentDate]) {
        self.leftBtn.enabled = NO;
        _currentSelectDate = self.minimumDate;
    }else {
        self.leftBtn.enabled = YES;
        _currentSelectDate = currentSelectDate;
    }
    if ([laterDate isEqualToString:tempCurrentDate]) {
        self.rightBtn.enabled = NO;
        _currentSelectDate = self.maximumDate;
    }else {
        self.rightBtn.enabled = YES;
        _currentSelectDate = currentSelectDate;
    }
    self.titleLabel.text = [self.dateFormatter stringFromDate:_currentSelectDate];
    if (self.selectDate != nil) {
        self.selectDate(self.currentSelectDate);
    }
}
- (void)leftButtonClick {
    NSDate *tempDate = [NSDate getNewDateWithIntervalYear:0 intervalMonth:0 intervalDay:-1 currentDate:_currentSelectDate];
    self.currentSelectDate = tempDate;
}
- (void)rightButtonClick {
    NSDate *tempDate = [NSDate getNewDateWithIntervalYear:0 intervalMonth:0 intervalDay:1 currentDate:_currentSelectDate];
    self.currentSelectDate = tempDate;
}
#pragma mark - lazy
- (NSDateFormatter *)compareDateFormatter {
    if (_compareDateFormatter == nil) {
        _compareDateFormatter = [[NSDateFormatter alloc] init];
        _compareDateFormatter.dateFormat = @"YYYY年MM月dd日";
    }
    return _compareDateFormatter;
}
- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LK_17font;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (UIButton *)leftBtn {
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"notes_calender_icon_left"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setImage:[UIImage imageNamed:@"notes_calender_icon_right"] forState:UIControlStateNormal];

    }
    return _rightBtn;
}
@end
