//
//  LKWorkRecordViewModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKWorkRecordViewModel.h"

@implementation LKWorkRecordViewModel
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
    [[RACObserve(self,requestDict) ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag];
    }];
}

-(void)requestData{
    @weakify(self)
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  array) {
//        NSNumber *retag = [array objectAtIndex:0];
        NSString * requestJson = [array objectAtIndex:1];
        @strongify(self);
        NSDictionary *requestDict =  [LKCustomMethods dictionaryWithJsonString: requestJson];
        if ([[requestDict numberForKey:@"status"] intValue] == 1) {
            NSString *data = [LKEntcry decryptAES:[requestDict objectForKey:@"data"]];
            id  dataArray = [LKCustomMethods arrayWithJsonString:data];
            if (dataArray != nil && [dataArray isKindOfClass:[NSArray class]]) {
                @strongify(self);
                NSMutableArray *tempDataArray = [NSMutableArray array];
                NSArray<LKWorkRecordListModel *> *tableViewDataSource = [LKWorkRecordListModel mj_objectArrayWithKeyValuesArray:(NSArray *)dataArray];
                LKTableSectionObject * sectionObject = [[LKTableSectionObject alloc]init];
                sectionObject.itemArray = [NSMutableArray arrayWithArray:tableViewDataSource];
                if (tableViewDataSource.count > 0) {
                    [tempDataArray addObject:sectionObject];
                }
                self.dataArray = tempDataArray;
            
                [self.loadDataSubject sendNext:self.dataArray];
            }else {
                [LKCustomMethods showWindowMessage:[requestDict objectForKey:@"msg"]];
            }
        }else{
            [LKCustomMethods showWindowMessage:[requestDict  stringForKey:@"msg"] ];
        }
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray * array) {
        NSError * error = [array objectAtIndex:1];
        [LKCustomMethods showWindowMessage:error.localizedDescription];
    }];
    
}
#pragma mark table -delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:section];
    return sectionObject.itemArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKWorkRecordCell *cell = [LKWorkRecordCell cellForTableView:tableView reuseIdentifier:@"LKWorkRecordCell"];
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    [cell bindData:[sectionObject.itemArray objectAtIndex:indexPath.row] indexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LKTableSectionObject * section = [self.dataArray objectAtIndex:indexPath.section];
    LKWorkRecordListModel * model = [section.itemArray objectAtIndex:indexPath.row];
    [self.cellClickSubject sendNext:model];
}

- (RACSubject *)loadDataSubject {
    if (_loadDataSubject == nil) {
        _loadDataSubject = [RACSubject subject];
    }
    return _loadDataSubject;
}
@end
