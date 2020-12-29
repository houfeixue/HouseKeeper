//
//  LKQualityDetailViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityDetailViewModel.h"
#import "LKQualityDetailViewCell.h"
#import "LKQualityDetailModel.h"
#import "SDPhotoBrowser.h"

@interface LKQualityDetailViewModel()<SDPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *showPictureArray;
@end

@implementation LKQualityDetailViewModel

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
        
        [self requestUrl:self.requestUrl withData:requestDict withRequestType:RequestType_Post  withTag:self.requestTag];
        
    }];
    
    //    //cell的点击
    //    [self.tableDidSelectSubject subscribeNext:^(NSIndexPath * index) {
    //        NSInteger  d = index.row;
    //        NSLog(@"tableDidSelectSubject : %d ",d);
    //    }];
    
}

-(void)requestData{
    
    @weakify(self)
    
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *resultArray) {
        NSLog(@"请求接口完成%@-%@ : %@",self.requestUrl,self.requestDict,resultArray);
        
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:[resultArray objectAtIndex:1]];
        int successResult = [[requestJson numberForKey:@"status"] intValue];
        if (successResult == 1) {
            NSString * data = [LKEntcry decryptAES:[requestJson objectForKey:@"data"]];
            id  dataArray = [LKCustomMethods arrayWithJsonString:data];
            if (dataArray != nil && [dataArray isKindOfClass:[NSArray class]]) {
                @strongify(self);
                LKTableSectionObject * section = nil;
                if (self.dataArray != nil && self.dataArray.count>0) {
                    section = [self.dataArray objectAtIndex:0];
                }else{
                    section = [[LKTableSectionObject alloc] init];
                }
                [section.itemArray removeAllObjects];
                //todo 处理数据
                NSArray *sourceDataArray = [LKQualityDetailModel mj_objectArrayWithKeyValuesArray:(NSArray *)dataArray];
                if (sourceDataArray.count > 0) {
                    [section.itemArray addObjectsFromArray:((LKQualityDetailModel *)([sourceDataArray objectAtIndex:0])).items];
                }
                self.dataArray = [NSMutableArray arrayWithObject:section];
                [self.refreshUI sendNext:sourceDataArray];
    
            }else {
                [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
            }
        }else {
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
    }];
    
    [self.requestViewModelErrorSubject subscribeNext:^(NSArray * array) {
        NSError *error = [array objectAtIndex:1];
        [LKCustomMethods showWindowMessage:error.localizedDescription];
    }];

}
//lazy
-(RACSubject *)tableDidSelectSubject
{
    if (_tableDidSelectSubject == nil) {
        _tableDidSelectSubject = [RACSubject subject];
    }
    return _tableDidSelectSubject;
}

#pragma mark table -delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:section];
    return sectionObject.itemArray.count;

    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", @"LKQualityDetailViewCell"];
    LKQualityDetailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    LKQualityDetailListModel *model = [sectionObject.itemArray objectAtIndex:indexPath.row];
    [cell conFigCellwithData:model atIndex:indexPath];
    @weakify(self);
    cell.imageTapBlock = ^(NSInteger index, UIView *imageBgView) {
        @strongify(self);
        self.showPictureArray = [NSMutableArray arrayWithArray:model.images];
        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = index;
        photoBrowser.imageCount = model.images.count;
        photoBrowser.sourceImagesContainerView = imageBgView;
        [photoBrowser show];
    };
    return cell;
    
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    LKQualityDetailImageInfoModel *imageInfoModel = [self.showPictureArray objectAtIndex:index];
    return [[NSString stringWithFormat:@"%@%@",LKIconHost,imageInfoModel.url] toURL];
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return [UIImage imageNamed:LKPicture_Default];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKTableSectionObject * section = [self.dataArray objectAtIndex:indexPath.section];
    id model = [section.itemArray objectAtIndex:indexPath.row];
    
    [self.cellClickSubject sendNext:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    return [tableView fd_heightForCellWithIdentifier:@"LKQualityDetailViewCell" configuration:^(LKQualityDetailViewCell *cell) {
        
        [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
        
    }];
    
    
}
- (NSMutableArray *)showPictureArray {
    if (_showPictureArray == nil) {
        _showPictureArray = [NSMutableArray array];
    }
    return _showPictureArray;
}
@end
