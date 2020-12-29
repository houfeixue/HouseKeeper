//
//  LKWorkRecordTitleView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

typedef void(^LKWorkRecordTitleViewSelectDate)(NSDate *selectDate);

@interface LKWorkRecordTitleView : LKBaseView
@property (nonatomic, strong) NSDate *currentSelectDate;
@property (nonatomic, copy) LKWorkRecordTitleViewSelectDate selectDate;
@end
