//
//  LKLoginVerifyItemView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@interface LKLoginVerifyItemView : LKBaseView
@property (nonatomic, strong) UITextField *verifyTextField;
/** 明密文 */
@property (nonatomic, strong) UIButton *secureBtn;
@property (nonatomic, strong) UIButton *verifyCodeBtn;

- (void)bindAccountDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText;
- (void)bindQuickDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText;
- (void)bindRegisterDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText;

/** 验证码倒计时 */
- (void)verifyBtnSignal;
@end
