//
//  CollectionViewModel.m
//  demo
//
//  Created by lh on 17/3/4.
//  Copyright © 2017年 HLK. All rights reserved.
//

#import "LKBaseTableViewModel.h"

@implementation LKBaseTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}



-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
//table -delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray!=nil) {
        return self.dataArray.count;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSObject * sectionObject = [_dataArray objectAtIndex:section];
    if ([sectionObject isKindOfClass:[LKTableSectionObject class]]) {
        LKTableSectionObject *object =  (LKTableSectionObject *)sectionObject;
        return object.itemArray.count;
    }
    
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Class cellCalss = [self tableCellClass:indexPath];
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", NSStringFromClass(cellCalss)];
    LKBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    LKTableSectionObject * sectionObject = [_dataArray objectAtIndex:indexPath.section];
    [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
    return cell;
    
}

- (Class)tableCellClass:(NSIndexPath *)indexPath
{
    return [LKBaseTableViewCell class];
}
-(RACSubject *)refreshUI
{
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
-(RACSubject *)refreshEndSubject
{
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}
-(RACSubject *)cellClickSubject
{
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
-(RACSubject *)refreshLoadData{
    if (!_refreshLoadData) {
        _refreshLoadData = [RACSubject subject];
    }
    return _refreshLoadData;
}

-(RACCommand *)refreshDataCommand
{
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                self.pageIndex = 1;
                [self.refreshLoadData sendNext:nil];
                [subscriber sendCompleted];
                return nil;
                
            }];
        }];
    }
    return _refreshDataCommand;
}
-(RACCommand *)nextPageCommand
{
    if (!_nextPageCommand) {
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                self.pageIndex++;
                [self.refreshLoadData sendNext:nil];
                
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
    }
    return _nextPageCommand;
}
@end
