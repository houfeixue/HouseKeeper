//
//  LKLoginViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKLoginModel.h"

@interface LKLoginViewModel : LKRequestViewModel
@property (nonatomic, strong) LKLoginModel *loginModel;

/** 是否允许登录 */
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;
@property (nonatomic, strong, readonly) RACSignal *loginBtnColorSignal;

@property (nonatomic, strong) RACSubject *loginSuccessSubject;
@property (nonatomic, strong) RACSubject *verifyCodeSuccessSubject;



@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数

@end
