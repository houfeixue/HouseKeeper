//
//  LKMyViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/11.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMyViewModel.h"
#import "LKMyHeadserCell.h"


@implementation LKMyViewModel
{
    NSArray *dataDict;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBindData];
    }
    return self;
}

-(void)initBindData
{
    @weakify(self)
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *resultArray) {
        @strongify(self);
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:[resultArray objectAtIndex:1]];
        int successResult  = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            id data =  [LKCustomMethods objectWithJsonString:[LKEntcry decryptAES:[requestJson objectForKey:@"data"]]];
            self.myModel = [LKMyMessageModel mj_objectWithKeyValues:data];
            [self.successDataSubject sendNext: self.myModel];
        }else {
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
        
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray *errorArray) {
        NSError *error = [errorArray objectAtIndex:1];
        NSLog(@"%@",error.localizedDescription);
    }];
    [self requestData];
    [[RACObserve(self, requestDict) ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag showHub:YES];
        
    }];
}


-(void)requestData{
 
    
   dataDict= @[
                              @{@"pic":@"personal center_icon_notes",
                                @"title":@"抽查记录"
                                },
//                              @{@"pic":@"personalcenter_icon_village",
//                                @"title":@"我的小区"
//                                },
                              @{@"pic":@"personal center_icon_password",
                                @"title":@"登录密码修改"
                                },
                              @{@"pic":@"personal center_icon_update",
                                @"title":@"当前版本"
                                },
                              @{@"pic":@"personal center_icon_sign out",
                                @"title":@"退出登录"
                                }
                              ];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataDict.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"LKMyHeadserCell";
    LKMyHeadserCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LKMyHeadserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillCellWithDictionary:dataDict[indexPath.row]];
    if (indexPath.row<2 ) {
        cell.rightImageView.hidden = NO;
        cell.versionImageView.hidden = YES;
        cell.rightLable.hidden = YES;
    }else{
        
        if (indexPath.row == 2) {
            cell.rightLable.hidden = NO;
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            cell.rightLable.text = [NSString stringWithFormat:@"V%@",app_Version] ;
            
            NSString *newVerson = [UserDefaultsHelper getStringForKey:LKUser_LatestVersion];
            if([newVerson isEqualToString:app_Version]){
                cell.versionImageView.hidden = YES;
            }else{
                cell.versionImageView.hidden = NO;
            }
            
        }else{
           cell.versionImageView.hidden = YES;
            cell.rightLable.hidden = YES;
        }
        cell.rightImageView.hidden = YES;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.myCellBlock(indexPath);
   
}

-(LKMyMessageModel *)myModel{
    if (!_myModel) {
        _myModel = [[LKMyMessageModel alloc] init];
    }
    return _myModel;
}

-(RACSubject *)successDataSubject
{
    if (_successDataSubject == nil) {
        _successDataSubject = [RACSubject subject];
    }
    return _successDataSubject;
}

@end
