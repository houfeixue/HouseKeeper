//
//  LKSearchCommunityResultViewModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/22.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchCommunityResultViewModel.h"

@implementation LKSearchCommunityResultViewModel
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
    @weakify(self);
    [[[RACObserve(self, requestDict) ignore:nil] skip:1] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self);
        if ([LKCustomTool isBlankString:[requestDict objectForKey:@"name"]]) {
            [self.dataArray removeAllObjects];
            [self.loadCommunityDataSubject sendNext:nil];
        }else {
            [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post withTag:self.requestTag];
        }
    }];
}
- (void)requestData {
    
    @weakify(self)
    
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  array) {
        
        NSNumber *retag = [array objectAtIndex:0];
        NSString * requestJson = [array objectAtIndex:1];
        @strongify(self);
        //小区列表
        NSDictionary *requestDict =  [LKCustomMethods dictionaryWithJsonString: requestJson];
        if ([[requestDict numberForKey:@"status"] intValue] == 1) {
            NSString *data = [LKEntcry decryptAES:[requestDict objectForKey:@"data"]];
            id  dataArray = [LKCustomMethods arrayWithJsonString:data];
            if (dataArray != nil && [dataArray isKindOfClass:[NSArray class]]) {
                @strongify(self);
                NSMutableArray *tempDataArray = [NSMutableArray array];
                NSArray<LKSearchCommunityListModel *> *tableViewDataSource = [LKSearchCommunityListModel mj_objectArrayWithKeyValuesArray:(NSArray *)dataArray];
                for (LKSearchCommunityListModel * object in tableViewDataSource) {
                    LKTableSectionObject * sectionObject = [[LKTableSectionObject alloc]init];
                    sectionObject.sectionKey = object.alpha;
                    sectionObject.itemArray = object.communitys.mutableCopy;
                    [tempDataArray addObject:sectionObject];
                }
                self.dataArray = tempDataArray;
                [self.loadCommunityDataSubject sendNext:nil];
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
- (void)changeSelectDataArray:(NSMutableArray *)currentSelectArray {
    self.selectCommunityArray = currentSelectArray;
    for (NSInteger i = 0; i<self.dataArray.count; i++) {
        LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:i];
        for (NSInteger index = 0; index < sectionObject.itemArray.count; index ++ ) {
            LKSearchCommunityModel *communityModel = [sectionObject.itemArray objectAtIndex:index];
            communityModel.selected = NO;
            for (LKSearchCommunityModel *selectCommunityModel in currentSelectArray) {
                if (communityModel.communityId == selectCommunityModel.communityId) {
                    communityModel.selected = YES;
                    break;
                }
            }
            [sectionObject.itemArray replaceObjectAtIndex:index withObject:communityModel];
            
        }
        [self.dataArray replaceObjectAtIndex:i withObject:sectionObject];
    }
    [self.changeCommunitySubject sendNext:nil];
}
#pragma mark table -delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:section];
    return sectionObject.itemArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKSearchCommunityCell *cell = [LKSearchCommunityCell cellForTableView:tableView reuseIdentifier:@"LKSearchCommunityCell"];
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    [cell conFigCellwithData:sectionObject.itemArray[indexPath.row] atIndex:indexPath];
    @weakify(self);
    cell.selectBtnChangeStatus = ^(LKSearchCommunityModel *communityModel) {
        @strongify(self);
        [sectionObject.itemArray replaceObjectAtIndex:indexPath.row withObject:communityModel];
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionObject];

        BOOL isHaveAddSelected = NO;
        for (LKSearchCommunityModel *tempMdoel in self.selectCommunityArray) {
            if (communityModel.communityId == tempMdoel.communityId) {
                if (communityModel.selected == NO ) {
                    [self.selectCommunityArray removeObject:tempMdoel];
                }else {
                    [self.selectCommunityArray addObject:communityModel];
                }
                isHaveAddSelected = YES;
                break;
            }
        }
        if (isHaveAddSelected == NO) {
            [self.selectCommunityArray addObject:communityModel];
        }
        [self.selectCommunitySubject sendNext:self.selectCommunityArray];
    };
    return cell;
    
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    LKTableSectionObject * section = [self.dataArray objectAtIndex:indexPath.section];
//    id model = [section.itemArray objectAtIndex:indexPath.row];
//
//    //    [self.cellClickSubject sendNext:model];
//
//    [self.cellClickSubject sendNext:@"reload"];
//
//}
- (RACSubject *)loadCommunityDataSubject {
    if (_loadCommunityDataSubject == nil) {
        _loadCommunityDataSubject = [RACSubject subject];
    }
    return _loadCommunityDataSubject;
}
- (RACSubject *)changeCommunitySubject {
    if (_changeCommunitySubject == nil) {
        _changeCommunitySubject = [RACSubject subject];
    }
    return _changeCommunitySubject;
}
- (NSMutableArray *)selectCommunityArray {
    if (_selectCommunityArray == nil) {
        _selectCommunityArray = [NSMutableArray array];
    }
    return _selectCommunityArray;
}
- (RACSubject *)selectCommunitySubject {
    if (_selectCommunitySubject == nil) {
        _selectCommunitySubject = [RACSubject subject];
    }
    return _selectCommunitySubject;
}
@end
