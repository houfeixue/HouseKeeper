//
//  ColorUtil.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/11.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtil : NSObject
+ (UIColor*)colorWithHex:(NSString*)stringToConvert;
+ (UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
@end
