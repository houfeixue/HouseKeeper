//
//  TestModel.m
//  Project
//
//  Created by heshenghui on 2018/7/4.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKHomeListViewModel.h"
#import "LKHomeTableViewCell.h"
@implementation LKHomeListViewModel

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
    
    //cell的点击
    [self.tableDidSelectSubject subscribeNext:^(NSIndexPath * index) {
        NSInteger  d = index.row;
        NSLog(@"tableDidSelectSubject : %ld ",d);
    }];
    
    
    
    
}

-(void)requestData{
    
    @weakify(self)
    
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  array) {
        
        NSNumber *retag = [array objectAtIndex:0];
        NSString * requestJson = [array objectAtIndex:1];
        NSLog(@"请求接口完成- --%@ ---%@ : %@",retag,self.requestDict,requestJson);
       
        
        
        @strongify(self);
        
        LKTableSectionObject * section = nil;
        if (self.dataArray!=nil&&self.dataArray.count>0) {
            section = [self.dataArray objectAtIndex:0];
        }else{
            section = [[LKTableSectionObject alloc]init];
        }
        if (self.pageIndex == 1) {
            [section.itemArray removeAllObjects];
        }
        
         //todo 处理数据
        [section.itemArray addObject:@"1"];
        [section.itemArray addObject:@"2"];
        [section.itemArray addObject:@"3"];
        [self.dataArray removeAllObjects];
        [self.dataArray addObject:section];
        //总数
//        NSNumber *rowCount = [data numberForKey:@"total"];

        NSNumber *rowCount = @(10);
        if (section.itemArray.count>=[rowCount integerValue]) {
            [self.refreshEndSubject sendNext:@(FooterRefresh_HasNoMoreData)];
            
        }else{
            [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
            
        }
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray * array) {
        NSNumber *retag = [array objectAtIndex:0];

        NSError * error = [array objectAtIndex:1];
        NSLog(@"error : %@,%@",retag,error.localizedDescription);
    }];
    
    
    
}

//#pragma table delegate
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Class cellCalss = [self tableCellClass:indexPath];
//    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", NSStringFromClass(cellCalss)];
//    LKBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[LKBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
//        
//    }
//    
//    LKTableSectionObject * sectionObject = [_dataArray objectAtIndex:indexPath.section];
//    [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
//    
//    
//    return cell;
//}

//lazy


-(RACSubject *)pushDataSubject
{
    if (_pushDataSubject == nil) {
        _pushDataSubject = [RACSubject subject];
    }
    return _pushDataSubject;
}


-(RACSubject *)tableDidSelectSubject
{
    if (_tableDidSelectSubject == nil) {
        _tableDidSelectSubject = [RACSubject subject];
    }
    return _tableDidSelectSubject;
}
#pragma mark table -delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    Class cellCalss = [self tableCellClass:indexPath];
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", @"LKHomeTableViewCell"];
    LKHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
    WS(weakSelf)
    cell.btnClick = ^(NSString *status) {
        [weakSelf.cellClickSubject sendNext:[sectionObject.itemArray objectAtIndex:indexPath.row]];

    };
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKTableSectionObject * section = [self.dataArray objectAtIndex:indexPath.section];
    id model = [section.itemArray objectAtIndex:indexPath.row];
    
    [self.cellClickSubject sendNext:model];
}

@end
