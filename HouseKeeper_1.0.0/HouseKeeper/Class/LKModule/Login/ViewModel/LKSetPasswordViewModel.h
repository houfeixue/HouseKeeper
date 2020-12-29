//
//  LKSetPasswordViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKSetPasswordModel.h"

@interface LKSetPasswordViewModel : LKRequestViewModel
@property (nonatomic, strong) LKSetPasswordModel *setPasswordModel;


/** 是否允许提交 */
@property (nonatomic, strong, readonly) RACSignal *enableSubmitSignal;
@property (nonatomic, strong, readonly) RACSignal *submitBtnColorSignal;

@property (nonatomic, strong) RACSubject *passwordSetSuccessSubject;

@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数
@end
