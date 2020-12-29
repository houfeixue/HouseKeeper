//
//  UIView+MBPHUD.m
//  HBGovSwift
//
//  Created by 余汪送 on 2017/12/11.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "UIView+MBPHUD.h"


#define MBPHUD_EXECUTE(...) \
__weak typeof(self) weakself = self; \
[self hideHUDCompletion:^{ \
[weakself.HUD removeFromSuperview]; \
    __VA_ARGS__ \
}];

CGFloat const MBPHUDFontSize = 15;
CGFloat const MBPHUDShowTime = 2.0f;


@implementation UIView (MBPHUD)
XNRefreshView *refreshView ;
@dynamic HUD;

- (MBProgressHUD *)HUD {
    return [MBProgressHUD HUDForView:self];
}

- (MBProgressHUD *)instanceHUD {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self];
    refreshView = [[XNRefreshView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    refreshView.tintColor = [UIColor colorWithRed:192/255.0 green:97/255.0 blue:99/255.0 alpha:1];
    refreshView.lineWidth = 2.f;
    refreshView.style = XNRefreshViewStyleLoading;
    [self setupHUD:HUD];
    return HUD;
}

- (void)showHUD {
    [self showLoadHUD];
}
- (void)showLoadHUD {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        [weakself addSubview:HUD];
        HUD.mode = MBProgressHUDModeCustomView;
        refreshView.style = XNRefreshViewStyleLoading;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadingBgView"]];
        if (refreshView.isAnimating) {
            [refreshView stopAnimation];
        }
        [HUD.customView addSubview:refreshView];
        refreshView.centerX = HUD.customView.centerX;
        refreshView.centerY = HUD.customView.centerY-1;

        [refreshView startAnimation];
        HUD.bezelView.backgroundColor = [UIColor clearColor];
        [HUD showAnimated:YES];
    })
}
- (void)showHUDWithMessage:(nullable NSString *)message {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        [weakself addSubview:HUD];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.label.text = message;
        [HUD showAnimated:YES];
    })
}

- (void)showHUDMessage:(NSString *)message {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        [weakself addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = message;
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:MBPHUDShowTime];
    })
}

- (void)showHUDWithImage:(UIImage *)image {
    [self showHUDWithImage:image message:nil];
}

- (void)showHUDWithImage:(UIImage *)image message:(nullable NSString *)message {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        HUD.label.text = message;
        [weakself addSubview:HUD];
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:MBPHUDShowTime];
    })
}

- (void)showHUDProgressHUD {
    [self showHUDProgressWithMessage:nil];
}

- (void)showHUDProgressWithMessage:(nullable NSString *)message {
    [self showHUDProgressWithMessage:message style:MBPHUDProgressStyleNormal];
}

- (void)showHUDProgressWithMessage:(nullable NSString *)message style:(MBPHUDProgressStyle)style {
    MBPHUD_EXECUTE({
        MBProgressHUDMode mode = MBProgressHUDModeDeterminate;
        if (style == MBPHUDProgressStyleBar) mode = MBProgressHUDModeDeterminateHorizontalBar;
        else if (style == MBPHUDProgressStyleAnnular) mode = MBProgressHUDModeAnnularDeterminate;
        MBProgressHUD *HUD = [weakself instanceHUD];
        HUD.mode = mode;
        HUD.label.text = message;
        [weakself addSubview:HUD];
        [HUD showAnimated:YES];
    })
}

- (void)updateHUDProgress:(CGFloat)progress {
    self.HUD.progress = progress;
}

- (void)hideHUD {
    [self hideHUDCompletion:nil];
}

- (void)hideHUDCompletion:(nullable void(^)(void))completion {
    if (!self.HUD) { if (completion) completion(); return; }
    self.HUD.completionBlock = completion;
    [self.HUD hideAnimated:YES];
}

- (void)setupHUD:(MBProgressHUD *)HUD {
    HUD.removeFromSuperViewOnHide = YES;
    HUD.square = NO;
    HUD.margin = 12;
    if (self.height == kScreen_Height) {

    }else {
        HUD.offset = CGPointMake(0.f,-MBProgressMaxOffset );
    }
    
    HUD.bezelView.color = [UIColor blackColor];
    HUD.bezelView.layer.cornerRadius = 4;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.label.font = [UIFont systemFontOfSize:MBPHUDFontSize];
    HUD.label.numberOfLines = 3;
}

@end
