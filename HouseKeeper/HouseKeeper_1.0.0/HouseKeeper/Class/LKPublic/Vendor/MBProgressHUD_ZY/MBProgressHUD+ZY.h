//
//  MBProgressHUD+ZY.h
//  lvdongqing
//
//  Created by sunny on 15/8/28.
//  Copyright (c) 2015年 LinkU. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ZY)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

/// 提示成功
+ (void)showSuccess:(NSString *)success;
/// 提示失败
+ (void)showError:(NSString *)error;

/// 默认显示动画
+ (void)hideHUDForView:(UIView *)view;
/// 隐藏所有动画
+ (void)hideAllHudForView:(UIView *)view;

/// 只显示信息，需要手动结束
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
/// 只显示信息，1s后自定移除
+ (void)showMessage:(NSString *)message ToView:(UIView *)view;

/// 只显示菊花
+ (void)showHUDToView:(UIView *)view;
/// 显示动画---显示在哪个View中在哪个View中隐藏
+ (void)showAnimationToView:(UIView *)view WithImageArray:(NSArray *)imageArray;

@end
