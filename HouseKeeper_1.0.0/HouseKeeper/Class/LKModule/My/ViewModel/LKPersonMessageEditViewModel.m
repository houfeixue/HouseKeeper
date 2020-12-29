//
//  LKPersonMessageEditViewModel.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPersonMessageEditViewModel.h"
#import "LKPersonMessageFirstCell.h"

@implementation LKPersonMessageEditViewModel
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
        int successResult = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            
            [self.successDataSubject sendNext: nil];
        }else {
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
        
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray *errorArray) {
        NSError *error = [errorArray objectAtIndex:1];
        NSLog(@"%@",error.localizedDescription);
    }];
    [[RACObserve(self, requestDict) ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag showHub:YES];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return 1;
    else  return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) return 70;
    else return 55;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1 || section == 2){
        return 10;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"LKPersonMessageFirstCell";
    LKPersonMessageFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LKPersonMessageFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.valueTextFiled.hidden = YES;
        cell.personImageView.hidden = NO;
        if ([self.messageModel.portrait containsString:@"group"]) {
            NSString *urltring = [NSString stringWithFormat:@"%@%@",LKIconHost,self.messageModel.portrait];
            [cell.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:[UIImage imageNamed:@"homePicDefault"]];
        }else{
            NSString *urltring = [NSString stringWithFormat:@"%@%@",LKPHPIconHost,self.messageModel.portrait];
            [cell.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:[UIImage imageNamed:@"homePicDefault"]];
        }
       
        cell.titleLable.text = @"头像";
    } else if (indexPath.section == 1) {
        cell.personImageView.hidden = YES;
         cell.valueTextFiled.hidden = NO;
        cell.valueTextFiled.enabled = NO;
        if(indexPath.row == 0){
            cell.titleLable.text = @"姓名";
            cell.valueTextFiled.text = self.messageModel.NAME;
        }else{
            cell.titleLable.text = @"身份";
            cell.valueTextFiled.text = self.messageModel.roleName;
        }
        
    }
    else{
        cell.personImageView.hidden = YES;
         cell.valueTextFiled.hidden = NO;
        cell.valueTextFiled.enabled = YES;
        if(indexPath.row == 0){
            cell.titleLable.text = @"工作单位";
            cell.valueTextFiled.text = self.messageModel.workPalace;
            cell.valueTextFiled.placeholder = @"请输入工作单位";
        }else{
            cell.titleLable.text = @"工号";
            cell.valueTextFiled.text =[NSString stringWithFormat:@"%@",self.messageModel.customerCode] ;
            cell.valueTextFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell.valueTextFiled.placeholder = @"请输入工号";
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        self.LKPersonMessageEditViewModel(indexPath);
    }
}



-(RACSubject *)successDataSubject
{
    if (_successDataSubject == nil) {
        _successDataSubject = [RACSubject subject];
    }
    return _successDataSubject;
}
@end
