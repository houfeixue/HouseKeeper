//
//  LKSetPasswordViewModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSetPasswordViewModel.h"

@implementation LKSetPasswordViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self requestData];
        [self setUp];
    }
    return self;
}
- (void)setUp{
    @weakify(self)
    [[RACObserve(self, requestDict) ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag];
        
    }];
}
- (void)requestData {
    _enableSubmitSignal = [RACSignal combineLatest:@[RACObserve(self.setPasswordModel, password),RACObserve(self.setPasswordModel, confirmPassword)] reduce:^id _Nonnull(NSString *password, NSString *confirmPassword){
        return @(password.length >= 6 && confirmPassword.length >= 6);
    }];
    _submitBtnColorSignal = [RACSignal combineLatest:@[RACObserve(self.setPasswordModel, password),RACObserve(self.setPasswordModel, confirmPassword)] reduce:^id _Nonnull(NSString *password, NSString *confirmPassword){
        if (password.length >= 6 && confirmPassword.length >= 6) {
            return LKBlackColor;
        }
        return LKDisableBtnColor;
    }];
    @weakify(self)
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *resultArray) {
        @strongify(self);
//        NSNumber *tag = [resultArray objectAtIndex:0];
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:[resultArray objectAtIndex:1]];
        int successResult = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            [self.passwordSetSuccessSubject sendNext: nil];
        }else {
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
        
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray *errorArray) {
        NSError *error = [errorArray objectAtIndex:1];
        [LKCustomMethods showWindowMessage:error.localizedDescription];
    }];
}

- (LKSetPasswordModel *)setPasswordModel {
    if (_setPasswordModel == nil) {
        _setPasswordModel = [[LKSetPasswordModel alloc] init];
    }
    return _setPasswordModel;
}
- (RACSubject *)passwordSetSuccessSubject {
    if (_passwordSetSuccessSubject == nil) {
        _passwordSetSuccessSubject = [RACSubject subject];
    }
    return _passwordSetSuccessSubject;
}
@end
