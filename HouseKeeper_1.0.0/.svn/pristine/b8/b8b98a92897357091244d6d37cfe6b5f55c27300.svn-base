//
//  NSDate+Extension.h
//  rqbao
//
//  Created by sunny on 2018/4/9.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour withNowData:(NSDate *)date;

/** currentDate     当前date
 *  intervalYear    相差几年
 *  intervalMonth   相差几月
 *  intervalDay     相差几天
 *  返回相差后的日期 NSDate
 */
+ (NSDate *)getNewDateWithIntervalYear:(NSInteger)intervalYear intervalMonth:(NSInteger)intervalMonth intervalDay:(NSInteger)intervalDay currentDate:(NSDate *)currentDate;
/** 跟date是否为同一年 */
- (BOOL)isThisYear:(NSDate *)date;

@end
