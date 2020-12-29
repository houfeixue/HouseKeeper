//
//  LKRegisterViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKRegisterModel.h"

@interface LKRegisterViewModel : LKRequestViewModel
@property (nonatomic, strong) LKRegisterModel *registerModel;


/** 是否允许下一步 */
@property (nonatomic, strong, readonly) RACSignal *enableNextSignal;
@property (nonatomic, strong, readonly) RACSignal *nextBtnColorSignal;

@property (nonatomic, strong) RACSubject *nextSuccessSubject;
@property (nonatomic, strong) RACSubject *verifyCodeSuccessSubject;

@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数
@end
