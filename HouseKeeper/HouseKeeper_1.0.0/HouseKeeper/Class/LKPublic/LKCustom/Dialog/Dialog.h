//
//  Dialog.h
//      
//
//  Created by 侯良凯 on 2018/6/29.
//

#import <Foundation/Foundation.h>
#import "LKInputAlertView.h"

@interface Dialog : NSObject

LKSingletonH(Dialog)

/** alertView */
+ (void)showCustomAlertViewWithTitle:(NSString *)title message:(NSString *)message ok:(void(^)(NSInteger index))ok;
/** alertView */
+ (void)showCustomAlertViewWithTitle:(NSString *)title message:(NSString *)message firstButtonName:(NSString *)firstButtonName secondButtonName:(NSString *)secondButtonName dismissHandler:(void(^)(NSInteger index))dismissHandler;
/** 修改按钮字体颜色alertView */
+ (void)showCustomAlertViewWithTitle:(NSString *)title message:(NSString *)message firstButtonName:(NSString *)firstButtonName  firstButtonColor:(UIColor *)color1 secondButtonName:(NSString *)secondButtonName secondButtonColor:(UIColor *)color2 dismissHandler:(void (^)(NSInteger index))dismissHandler;
/** 一键评分 alert */
+ (void)showScoreAlertViewWithMessage:(NSString *)message placeholderString:(NSString *)placeholderString score:(CGFloat)score dismissHandler:(void (^)(NSString *scoreString , NSInteger index, LKInputAlertView *inputAlertView))dismissHandler;
/** 一键评分 带有默认添加的分数 */
+ (void)showScoreAlertViewWithMessage:(NSString *)message inputText:(NSString *)inputText placeholderString:(NSString *)placeholderString score:(CGFloat)score dismissHandler:(void (^)(NSString *scoreString , NSInteger index, LKInputAlertView *inputAlertView))dismissHandler;
/** 基础inputAlert */
+ (void)showInputAlertViewWithTitle:(NSString *)title message:(NSString *)message tipMessage:(NSString *)tipMessage placeholderString:(NSString *)placeholderString score:(CGFloat)score firstButtonName:(NSString *)firstButtonName secondButtonName:(NSString *)secondButtonName dismissHandler:(void (^)(NSString *scoreString , NSInteger index, LKInputAlertView *inputAlertView))dismissHandler;
@end
