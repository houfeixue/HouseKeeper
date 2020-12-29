//
//  LKCalendarView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCalendarView.h"
#import <EventKit/EventKit.h>
#import "LunarFormatter.h"
#import "LKCalendarWeekDayView.h"

@interface LKCalendarView()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSArray<EKEvent *> *events;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (nonatomic, strong) LKCalendarWeekDayView *weekDayView;
@end

@implementation LKCalendarView


- (void)createUI {
    [super createUI];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.weekDayView];
    [self.weekDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [self addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekDayView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    //    self.calendar.frame = self.bounds;

    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [NSDate date];
    self.minimumDate = [NSDate getNewDateWithIntervalYear:-1 intervalMonth:0 intervalDay:0 currentDate:nowDate];
    self.maximumDate = nowDate;
    self.calendar.weekdayHeight = 0;
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    self.calendar.appearance.headerTitleTextAlignment = NSTextAlignmentLeft;
    self.calendar.appearance.headerTitleColor = LKGrayColor;
    self.calendar.appearance.headerTitleFont = LK_20font;
    self.calendar.appearance.titleSelectionColor = LKDisableGrayColor;
    self.calendar.appearance.todaySelectionColor = LKBlackColor;
    self.calendar.headerHeight = 60.0f;
    self.calendar.today = nil; // Hide the today circle
    self.calendar.appearance.selectionColor = LKBlackColor;
    self.calendar.rowHeight = 50.0f;
    self.calendar.appearance.titleFont = LK_16font;
    self.calendar.appearance.headerDateFormat = @"YYYY年M月";
    [self loadCalendarEvents];
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];

}
#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return self.maximumDate;
}

//- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
//    EKEvent *event = [self eventsForDate:date].firstObject;
//    if (event) {
//        return event.title;
//    }
//    return [self.lunarFormatter stringFromDate:date];
//}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    if (self.selectDate != nil) {
        self.selectDate(date);
    }
}

//- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
//    DLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
//}
//- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
//    if (!self.events) return 0;
//    NSArray<EKEvent *> *events = [self eventsForDate:date];
//    return events.count;
//}
//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date {
//    if (!self.events) return nil;
//    NSArray<EKEvent *> *events = [self eventsForDate:date];
//    NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:events.count];
//    [events enumerateObjectsUsingBlock:^(EKEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [colors addObject:[UIColor colorWithCGColor:obj.calendar.CGColor]];
//    }];
//    return colors.copy;
//}

#pragma mark - Private methods

- (void)loadCalendarEvents {
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
        if(granted) {
            NSDate *startDate = self.minimumDate;
            NSDate *endDate = self.maximumDate;
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf) return;
                weakSelf.events = events;
                [weakSelf.calendar reloadData];
            });
            
        } else {
            
//            // Alert
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Permission Error" message:@"Permission of calendar is required for fetching events." preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}
// 某个日期的所有事件
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date {
    
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        if (@available(iOS 9.0, *)) {
            return [evaluatedObject.occurrenceDate isEqualToDate:date];
        } else {
            // Fallback on earlier versions
            return NO;
        }
    }]];
    return filteredEvents;
}
- (void)getEventsData {
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            /** 开始日期 */
            NSDate *startDate = [NSDate date];
            /** 结束日期 */
            NSDate *endDate = [NSDate date];
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            /** 开始日期到结束日期的所有事件 */
            NSArray <EKEvent *>*eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            /** events变量只包含订阅事件，如春节、劳动节、圣诞节、夏至等，排除了用户在系统日历中自己添加的事件，如某某人的生日等。
             * 模拟器环境的系统日历中没有包含农历、节假日等订阅事件
             */
            NSArray <EKEvent *>*events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                return evaluatedObject.calendar.subscribed;
            }]];
            weakSelf.events = events;
        }
    }];
}

#pragma mark - lazy
- (FSCalendar *)calendar {
    if (_calendar == nil) {
        _calendar = [[FSCalendar alloc] init];
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.pagingEnabled = NO; // important
        _calendar.allowsMultipleSelection = NO;
        //    calendar.firstWeekday = 2;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesDefaultCase|FSCalendarCaseOptionsHeaderUsesDefaultCase;
    }
    return _calendar;
}
- (LunarFormatter *)lunarFormatter {
    if (_lunarFormatter == nil) {
        _lunarFormatter = [[LunarFormatter alloc] init];
    }
    return _lunarFormatter;
}
- (LKCalendarWeekDayView *)weekDayView {
    if (_weekDayView == nil) {
        _weekDayView = [[LKCalendarWeekDayView alloc] init];
    }
    return _weekDayView;
}
@end
