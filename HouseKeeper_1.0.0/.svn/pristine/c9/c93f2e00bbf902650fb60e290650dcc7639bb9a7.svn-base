//
//  LKBaseCollectionViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewModel.h"

@implementation LKBaseCollectionViewModel
- (Class)CollectCellClass:(NSIndexPath *)indexPath{
    return nil;
}
//lazy
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

//刷新数据
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


-(RACSubject *)refreshLoadData{
    if (!_refreshLoadData) {
        _refreshLoadData = [RACSubject subject];
    }
    return _refreshLoadData;
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

//collection -delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataArray!=nil) {
        return self.dataArray.count;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSObject * sectionObject = [_dataArray objectAtIndex:section];
    if ([sectionObject isKindOfClass:[LKCollectionSectionObject class]]) {
        LKCollectionSectionObject *object =  (LKCollectionSectionObject *)sectionObject;
        return object.itemArray.count;
    }
    
    return 0;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return [[UICollectionViewCell alloc]init];
}

@end
