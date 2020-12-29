//
//  LKWorkUpLoadViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKWorkUpLoadViewModel.h"
#import "LKQualityListModel.h"
#import "LKWorkUpLoadViewCell.h"

@implementation LKWorkUpLoadViewModel

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
        
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag];
        
    }];
    
}

-(void)requestData{
    
    @weakify(self)
    
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  array) {
        @strongify(self);
        
        NSNumber * requestTag = [array objectAtIndex:0];
        NSString * requestString = [array objectAtIndex:1];
        
        NSDictionary * requestDict = [LKCustomMethods dictionaryWithJsonString:requestString];
        
        if ([requestTag integerValue] == 1) {
            //请求列表接口
            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                
                
                [self.dataArray removeAllObjects];
                NSArray *dataArray =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]];
                
                LKTableSectionObject * sectionObject = [[LKTableSectionObject alloc]init];
                
                
                sectionObject.itemArray = [NSMutableArray arrayWithArray:[LKQualityListModel mj_objectArrayWithKeyValuesArray:dataArray]];
                
                [self.dataArray addObject:sectionObject];
                [self.cellClickSubject sendNext:@"mainViewRolad"];
                
            }else{
                
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];
            }
        }
    
    }];
}


#pragma mark -table delete

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", @"LKWorkUpLoadViewCell"];
    LKWorkUpLoadViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    
    LKQualityListModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
    [cell conFigCellwithData:model atIndex:indexPath];
    
    
    WS(weakSelf)
    
    cell.workUpLoadClick = ^(NSString *status) {
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:@"upload" forKey:@"type"];
        [dict setObject:model forKey:@"data"];

        [weakSelf.cellClickSubject sendNext:dict];
    };
    
    

    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

@end
