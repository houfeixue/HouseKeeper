//
//  LKRegisterItemView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@interface LKRegisterItemView : LKBaseView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *nextBtn;

- (void)bindDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText textFieldCanEdit:(BOOL)textFieldCanEdit isShowNextBtn:(BOOL)isShowNextBtn;
@end
