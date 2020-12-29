//
//  LKForgetPasswordViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKForgetPasswordModel.h"

@interface LKForgetPasswordViewModel : LKRequestViewModel
@property (nonatomic, strong) LKForgetPasswordModel *forgetPasswordModel;


/** 是否允许下一步 */
@property (nonatomic, strong, readonly) RACSignal *enableNextSignal;
@property (nonatomic, strong, readonly) RACSignal *nextBtnColorSignal;

@property (nonatomic, strong) RACSubject *verifyCodeSendSuccessSubject;
@property (nonatomic, strong) RACSubject *verifySuccessSubject;


@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数
@end
