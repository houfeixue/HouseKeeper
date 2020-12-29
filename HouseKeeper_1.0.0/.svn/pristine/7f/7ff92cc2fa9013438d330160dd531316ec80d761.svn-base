//
//  MBProgressHUD+ZY.m
//  lvdongqing
//
//  Created by sunny on 15/8/28.
//  Copyright (c) 2015年 LinkU. All rights reserved.
//

#import "MBProgressHUD+ZY.h"

static UIImageView *imageView;

@implementation MBProgressHUD (ZY)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}



+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    if (imageView) {
        [imageView stopAnimating];
        imageView = nil;
    }
    if ([view.subviews indexOfObject:self] == NSNotFound) {
        for (UIView *v in view.subviews) {
            [self hideHUDForView:v animated:YES];
        }
    }else{
        [self hideHUDForView:view animated:YES];
    }
    
}

+ (void)hideAllHudForView:(UIView *)view{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    if (imageView) {
        [imageView stopAnimating];
        [imageView removeFromSuperview];
        imageView = nil;
    }
     NSArray *huds = [MBProgressHUD allHUDsForView:view];
    if (huds.count == 0) {
        for (UIView *v in view.subviews) {
            NSArray *hudss = [MBProgressHUD allHUDsForView:v];
            for (MBProgressHUD *hud in hudss) {
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES];
            }
        }

    }else{
        [self hideAllHUDsForView:view animated:YES];
    }
}
+ (void)hideHUD
{
    
    [self hideHUDForView:nil];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    return hud;
}

#pragma mark - 仅显示message
+ (void)showMessage:(NSString *)message ToView:(UIView *)view{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
#pragma mark - 只显示菊花
+ (void)showHUDToView:(UIView *)view{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    
     [MBProgressHUD showHUDAddedTo:view animated:YES];
}
#pragma mark - 显示动画
+ (void)showAnimationToView:(UIView *)view WithImageArray:(NSArray *)imageArray{
    if (imageArray.count == 0 || imageArray == nil) {
         imageArray = @[[UIImage imageNamed:@"loading30001.png"],[UIImage imageNamed:@"loading30002.png"],[UIImage imageNamed:@"loading30003.png"],[UIImage imageNamed:@"loading30004.png"],[UIImage imageNamed:@"loading30015.png"]];
    }
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置图片
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading30001.png"]];
    hud.color = [UIColor clearColor];
    hud.customView = [[UIView alloc] initWithFrame:imageView.bounds];
    [hud.customView addSubview:imageView];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //_imageView连续播放多张图片
    //设置动画数组
    imageView.animationImages=imageArray;
    //设置播放周期（播放一组图片周期）
    imageView.animationDuration = 0.5;
    //设置播放的次数
    imageView.animationRepeatCount = 0;
    //启动动画
    [imageView startAnimating];

}

@end
