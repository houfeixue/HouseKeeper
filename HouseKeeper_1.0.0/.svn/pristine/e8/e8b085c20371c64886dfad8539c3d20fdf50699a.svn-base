//
//  TestModel.m
//  Project
//
//  Created by heshenghui on 2018/7/4.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKHomeHeaderViewModel.h"

@implementation LKHomeHeaderViewModel

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
        
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Get  withTag:1];
        
    }];
    
    //cell的点击
    [self.tableDidSelectSubject subscribeNext:^(NSIndexPath * index) {
        NSInteger  d = index.row;
        NSLog(@"tableDidSelectSubject : %d ",d);
    }];
    
    
    
    
}

-(void)requestData{
    
    @weakify(self)
    
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  array) {
        NSLog(@"请求接口完成 : %@",array);
        //todo 处理数据
        @strongify(self);
        
        NSString * url = [array objectAtIndex:0];
        
        if([url containsString:@""]){
            
            
            
        }else if([url containsString:@"http:"]){
            
        }
        
        [self.dataArray addObject:@"1"];
        [self.dataArray addObject:@"2"];
        [self.dataArray addObject:@"3"];
        
        
        [self.pushDataSubject sendNext:self.dataArray];
        
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSError * x) {
        NSLog(@"%@",x.localizedDescription);
    }];
    
    
    
}

//lazy
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

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

@end
