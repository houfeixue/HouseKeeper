//
//  LKRegisterViewModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRegisterViewModel.h"

@implementation LKRegisterViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self requestData];
        [self setUp];
    }
    return self;
}
- (void)setUp {
    @weakify(self);
    [[RACObserve(self, requestDict) ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self);
        
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag];
        
    }];
}
- (void)requestData {
    _nextSuccessSubject = [RACSubject subject];
    _verifyCodeSuccessSubject = [RACSubject subject];
    _enableNextSignal = [RACSignal combineLatest:@[RACObserve(self.registerModel, userName),RACObserve(self.registerModel, verifyCode),RACObserve(self.registerModel, password)] reduce:^id _Nonnull(NSString *userName, NSString *verifyCode,NSString *password){
            return @(userName.length && password.length >= 6 && verifyCode.length >= 4);
    }];
    _nextBtnColorSignal = [RACSignal combineLatest:@[RACObserve(self.registerModel, userName),RACObserve(self.registerModel, verifyCode),RACObserve(self.registerModel, password)] reduce:^id _Nonnull(NSString *userName, NSString *verifyCode,NSString *password){
            if (userName.length && password.length >= 6 && verifyCode.length >= 4) {
                return LKBlackColor;
            }
            return LKDisableBtnColor;
    }];
    @weakify(self);
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *resultArray) {
        @strongify(self);
        NSNumber *tag = [resultArray objectAtIndex:0];
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:[resultArray objectAtIndex:1]];
        int successResult = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            if ([tag isEqualToNumber: @(1)]) { /// 验证码
                [LKCustomMethods showWindowMessage:@"验证码已发送"];
                [self.verifyCodeSuccessSubject sendNext:nil];
            }else if ([tag isEqualToNumber:@(2)]) {
                NSString * data = [LKEntcry decryptAES:[requestJson objectForKey:@"data"]];
                id  dataDict = [LKCustomMethods dictionaryWithJsonString:data];
                if (dataDict != nil && [dataDict isKindOfClass:[NSDictionary class]]) {
                    @strongify(self);
                    LKUserInfoModel * model = [LKUserInfoModel mj_objectWithKeyValues:(NSDictionary *)dataDict];
                    [self.nextSuccessSubject sendNext:model];
                }else {
                    [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
                }
            }

        }else {
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray *errorArray) {
        NSError *error = [errorArray objectAtIndex:1];
        [LKCustomMethods showWindowMessage:error.localizedDescription];
    }];
}

- (LKRegisterModel *)registerModel {
    if (_registerModel == nil) {
        _registerModel = [[LKRegisterModel alloc] init];
    }
    return _registerModel;
}
@end
