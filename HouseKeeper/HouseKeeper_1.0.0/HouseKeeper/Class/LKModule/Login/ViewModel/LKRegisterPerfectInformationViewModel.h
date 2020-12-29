//
//  LKRegisterPerfectInformationViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKRegisterPerfectInformationModel.h"
#import "LKRegisterHouseKeeperIdentifyModel.h"

@interface LKRegisterPerfectInformationViewModel : LKRequestViewModel
@property (nonatomic, strong) LKRegisterPerfectInformationModel *perfectInformationModel;


/** 是否允许下一步 */
@property (nonatomic, strong, readonly) RACSignal *enableNextSignal;
@property (nonatomic, strong, readonly) RACSignal *nextBtnColorSignal;

@property (nonatomic, strong) RACSubject *loadRoleDataSubject;
@property (nonatomic, strong) RACSubject *auditSuccessSubject;

@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数

@end
