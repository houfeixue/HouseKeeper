//
//  LKCalendarView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"
#import "FSCalendar.h"

typedef void(^LKCalendarViewSelectDate)(NSDate *selectedDate);

@interface LKCalendarView : LKBaseView
@property (nonatomic, strong) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (nonatomic, copy) LKCalendarViewSelectDate selectDate;
@end
