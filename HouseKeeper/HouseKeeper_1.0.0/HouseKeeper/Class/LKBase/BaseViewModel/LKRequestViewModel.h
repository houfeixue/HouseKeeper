//
//  LKRequestViewModel.h
//  Project
//
//  Created by heshenghui on 2018/7/1.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,RequestType) {
    RequestType_Get,
    RequestType_Post,
};

@interface LKRequestViewModel : LKBaseViewModel

@property (nonatomic, strong) RACSubject *requestViewModelOKSubject;//接口请求成功
@property (nonatomic, strong) RACSubject *requestViewModelErrorSubject;//接口请求失败
@property (nonatomic, assign) NSInteger requestTag;//请求接口Tag

-(void)requestUrl:(NSString *) url withData:(NSDictionary *)dict withRequestType:(RequestType)requestType withTag:(NSInteger )tag;


-(void)requestUrl:(NSString *) url withData:(NSDictionary *)dict withRequestType:(RequestType)requestType withTag:(NSInteger )tag showHub:(BOOL)show;
@end

NS_ASSUME_NONNULL_END
