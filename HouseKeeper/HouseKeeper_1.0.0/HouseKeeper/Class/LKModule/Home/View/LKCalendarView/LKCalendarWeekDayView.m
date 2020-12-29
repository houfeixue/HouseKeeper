//
//  LKCalendarWeekDayView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCalendarWeekDayView.h"

@implementation LKCalendarWeekDayView

- (void)createUI{
    [super createUI];
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
    lineView.backgroundColor = LKF2Color;
    NSArray *array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat labelWidth = kScreen_Width/7.0f;
    for (NSInteger i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [array objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = LK_13font;
        label.textColor = LKGrayColor;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*labelWidth);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(labelWidth);
            make.bottom.equalTo(lineView.mas_top);
        }];
    }
 
}

@end
