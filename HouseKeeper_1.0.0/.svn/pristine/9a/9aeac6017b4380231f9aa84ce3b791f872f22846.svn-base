//
//  LKPersonMessageEditViewModel.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKMyMessageModel.h"

@interface LKPersonMessageEditViewModel : LKRequestViewModel<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy) void(^LKPersonMessageEditViewModel)(NSIndexPath *index);

@property(nonatomic,strong) LKMyMessageModel *messageModel;

@property (nonatomic, strong) RACSubject *successDataSubject;
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数

@end
