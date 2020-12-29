//
//  LKQualityListViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityListViewModel.h"
#import "LKQualityListVIewCell.h"
#import "LKQualityListSectionHeaderView.h"
#import "LKQualityListModel.h"
#import "LKQualityInfoModel.h"

@implementation LKQualityListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self requestData];
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    
    @weakify(self)
    [[RACObserve(self,requestDict)ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        NSLog(@"RACObserve 请求接口 url:%@ :  %@",self.requestUrl,requestDict);
        
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag showHub:YES];
        
    }];
    
    [[RACObserve(self,sumbit)skip:1] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        //是否存在未提交的图片
        BOOL isNoLoadImage = NO;
        for (int i=0; i<self.dataArray.count; i++) {
            
            LKQualityListModel * sectionObject = [self.dataArray objectAtIndex:i];
            NSArray * imageArray = [LKCustomMethods getUpLoadImagesCountFromCategoryId:sectionObject.detailId];
            NSInteger upLoadImageCount=0;
            for (int i=0; i<imageArray.count; i++) {
                LKUpLoadPictureModel * model = [imageArray objectAtIndex:i];
                if (model.upLoad) {
                    upLoadImageCount ++;
                }
            }
            if (upLoadImageCount != imageArray.count) {
                isNoLoadImage = YES;
            }
        }
        if (isNoLoadImage) {
            [LKCustomMethods showWindowMessage:@"当前有照片未上传完成，不可进行提交"];
            return ;
        }
                    [Dialog showCustomAlertViewWithTitle:@"提示" message:@"提交后不可修改" firstButtonName:@"确定" firstButtonColor:LKLightGrayColor secondButtonName:@"取消" secondButtonColor:LKLightGrayColor  dismissHandler:^(NSInteger index) {
                        if (index ==  0) {
                            self.requestUrl = LKSubmitEnd;
                            self.requestTag = 3;
                            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                            if (self.dataArray.count>0) {
                                LKQualityListModel * model =[self.dataArray objectAtIndex:0];
                                [dict setObject:@"1" forKey:@"endFlag"];
                                [dict setObject:@"0" forKey:@"submitType"];
                                [dict setObject:model.checkRecordId forKey:@"checkRecordId"];
                            }
                            self.requestDict = dict;
                        }
                    }];
    }];
}

-(void)requestData{
    
    @weakify(self)
//
//    NSString * str =  [LKEntcry decryptAES:@"DbZ/LgagHGJ8v7/mvIT5xA=="];
//    DLog(@"str : %@",str);
    
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  array) {
        @strongify(self);
        
        NSNumber * requestTag = [array objectAtIndex:0];
        NSString * requestString = [array objectAtIndex:1];
        
        NSDictionary * requestDict = [LKCustomMethods dictionaryWithJsonString:requestString];
        
        if ([requestTag integerValue] == 1) {
            //请求列表接口
            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                
                
                [self.dataArray removeAllObjects];
                DLog(@"%@",[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]);
                NSArray *dataArray =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]];
                
                self.dataArray = [NSMutableArray arrayWithArray:[LKQualityListModel mj_objectArrayWithKeyValuesArray:dataArray]];
                
                [self.cellClickSubject sendNext:@"mainViewRolad"];
                double scoreCount = 0;
                for (int i=0; i<self.dataArray.count; i++) {
                    LKQualityListModel *model = [self.dataArray objectAtIndex:i];
                    scoreCount += model.scort;
                }
                NSMutableDictionary * scoreDict = [[NSMutableDictionary alloc]init];
                [scoreDict setObject:@"scoreCount" forKey:@"key"];
                [scoreDict setObject:[NSString stringWithFormat:@"%lf",scoreCount] forKey:@"data"];
                [scoreDict setObject:@(self.dataArray.count) forKey:@"dataCount"];

                [self.cellClickSubject sendNext:scoreDict];

                
            }else{
                [self.dataArray removeAllObjects];
                NSMutableDictionary * scoreDict = [[NSMutableDictionary alloc]init];
                [scoreDict setObject:@"scoreCount" forKey:@"key"];
                [scoreDict setObject:@"0" forKey:@"data"];
                [scoreDict setObject:@(0) forKey:@"dataCount"];

                [self.cellClickSubject sendNext:scoreDict];
                [self.cellClickSubject sendNext:@"mainViewRolad"];

                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];
            }
        }else if ([requestTag integerValue] == 2) {
            
            NSDictionary * paramDict = [array objectAtIndex:2];
            
            NSNumber *  parentId = [paramDict numberForKey:@"parentId"];
            
            //一键评分
            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                
                
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];
                
                NSInteger section =0;
                LKQualityListModel * selectModel = nil;
                for (int i=0; i<self.dataArray.count; i++) {
                    LKQualityListModel * model = [self.dataArray objectAtIndex:i];
                    
                    if ([model.detailId integerValue] == [parentId integerValue]) {
                        section = i;
                        selectModel = model;
                        break;
                    }
                }
                
                self.requestUrl = LKGetRuleByCategroyId;
                self.requestTag = 100+section;
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setObject:selectModel.checkRecordId forKey:@"checkRecordId"];
                [dict setObject:@"2" forKey:@"level"];
                [dict setObject:parentId forKey:@"parentId"];
                self.requestDict = dict;
                //评分成功
                [self.cellClickSubject sendNext:@"GiveScoreOK"];
                
                
            }else{
                
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];
            }
        }else if ([requestTag integerValue] == 3) {
            //提交接口
            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                [self.cellClickSubject sendNext:@"submitSucess"];
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];

                
            }else{
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];

            }
        }
        else if ([requestTag integerValue] >=100 ){
            
            //细列表接口

            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                NSArray *dataArray =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]];
                
                
                LKQualityListModel * sectionObject = [self.dataArray objectAtIndex:[requestTag integerValue] - 100];
                
                sectionObject.itemArray = [NSMutableArray arrayWithArray:[LKQualityInfoModel mj_objectArrayWithKeyValuesArray:dataArray]];
                
                [self.dataArray replaceObjectAtIndex:[requestTag integerValue] - 100 withObject:sectionObject];
                
                [self.cellClickSubject sendNext:@"mainViewRolad"];
                
            }else{
                
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];
            }
        }
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray *  array) {
        NSLog(@"%@",array);
    }];
    
    
    
}

#pragma mark table -delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LKQualityListModel * sectionObject = [self.dataArray objectAtIndex:section];
    if (sectionObject.isShow) {
        return sectionObject.itemArray.count;
    }else{
        return 0;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LKQualityListSectionHeaderView * view = [[LKQualityListSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 140)];
    LKQualityListModel * sectionObject = [self.dataArray objectAtIndex:section];
    
    [view setViewUIWithModel:sectionObject];
    
    WS(weakSelf);
    
    
    view.qualityUpLoadClick = ^(NSString *status) {
        //上传图片完成
        [weakSelf.cellClickSubject sendNext:@"UpLoadImage"];
    };
    
    view.qualityBtnClick = ^(NSString *status) {
        if ([status isEqualToString:@"isFold"]) {
            //展示/收起
            
            if (sectionObject.isShow == NO) {
                //
                weakSelf.requestUrl = LKGetRuleByCategroyId;
                weakSelf.requestTag = 100+section;
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setObject:sectionObject.checkRecordId forKey:@"checkRecordId"];
                [dict setObject:@"2" forKey:@"level"];
                [dict setObject:sectionObject.detailId forKey:@"parentId"];
                weakSelf.requestDict = dict;
                
            }
            
            sectionObject.isShow = !sectionObject.isShow;
            [weakSelf.dataArray replaceObjectAtIndex:section withObject:sectionObject];
            [weakSelf.cellClickSubject sendNext:@"mainViewRolad"];
        }else if ([status isEqualToString:@"look"]){
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:status forKey:@"key"];
            [dict setObject:sectionObject forKey:@"data"];
            //查看照片
            [weakSelf.cellClickSubject sendNext:dict];
            
            
        }else if ([status isEqualToString:@"upload"]){
            //上传照片
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:status forKey:@"key"];
            [dict setObject:sectionObject forKey:@"data"];
            //查看照片
            [weakSelf.cellClickSubject sendNext:dict];
            
            
        }
    };
    
    return view;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", @"LKQualityListVIewCell"];
    LKQualityListVIewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    LKQualityListModel * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
    WS(weakSelf)
    
    cell.qualityListCellClick = ^(NSString *status) {
        if ([status isEqualToString:@"score"]) {
            //一键评分
            LKQualityInfoModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:status forKey:@"key"];
            
            [dict setObject:model forKey:@"data"];
            
            [weakSelf.cellClickSubject sendNext:dict];
        }
    };

    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKQualityListModel * section = [self.dataArray objectAtIndex:indexPath.section];
//    id model = [section.itemArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"detail" forKey:@"key"];
    [dict setObject:section forKey:@"data"];
    [dict setObject:@(indexPath.row) forKey:@"index"];
    
    [self.cellClickSubject sendNext:dict];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    return [tableView fd_heightForCellWithIdentifier:@"LKQualityListVIewCell" configuration:^(LKQualityListVIewCell *cell) {
        
        [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
        
    }];
    
    
}

@end
