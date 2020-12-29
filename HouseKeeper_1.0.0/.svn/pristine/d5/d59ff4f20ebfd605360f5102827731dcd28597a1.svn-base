//
//  LKPictureViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKUrlPictureViewModel.h"
#import "LKPictureCell.h"
#import "LKUrlPictureModel.h"

@implementation LKUrlPictureViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isEndDecelerating = YES;
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
    
    [[RACObserve(self,isSelectAll)skip:1]subscribeNext:^(id  _Nullable x) {
        @strongify(self)

        NSLog(@"%d",self.isSelectAll);
         LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:0];
        for (int i=0; i<sectionObject.itemArray.count; i++) {
            LKUrlPictureModel * model = [sectionObject.itemArray objectAtIndex:i];
            model.isSelect = self.isSelectAll;
        }
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"SelectAll" forKey:@"type"];
        [dict setObject:@([self selectImagesCount]) forKey:@"SelectCount"];

        [self.cellClickSubject sendNext:dict];
        
    }];
    
    [[RACObserve(self,sure)skip:1]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"upload" forKey:@"type"];
        [dict setObject:[self getSlelectImage] forKey:@"data"];
        [self.cellClickSubject sendNext:dict];
        
    }];

    [[RACObserve(self,deleteImages)skip:1]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
    
        self.requestTag = 2;
        self.requestUrl = LKDeleteAttachments;
        NSMutableArray * imageArray =[self getSlelectImage];
        NSMutableArray * imageIds =[[NSMutableArray alloc]init];;

        for (int i=0; i<imageArray.count; i++) {
            LKUrlPictureModel * model = [imageArray objectAtIndex:i];
            [imageIds addObject:model.attachmentId];
        }
        
        [Dialog showCustomAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"确认删除这%lu张照片",(unsigned long)imageIds.count] firstButtonName:@"确定" firstButtonColor:LKLightGrayColor secondButtonName:@"取消" secondButtonColor:LKLightGrayColor  dismissHandler:^(NSInteger index) {
            if (index ==  0) {
                NSString *imageIdsStr = [imageIds componentsJoinedByString:@","];
                self.requestDict = @{@"attachmentIds":imageIdsStr};
            }
        }];
    }];
}

-(NSMutableArray * )getSlelectImage
{
    
    NSMutableArray * selectImages = [[NSMutableArray alloc]init];
    
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:0];
    for (int i=0; i<sectionObject.itemArray.count; i++) {
        LKUrlPictureModel * model = [sectionObject.itemArray objectAtIndex:i];

        if (model.isSelect ) {
            [selectImages addObject:model];
        }

    }
    return selectImages;
}

-(void)requestData{
    @weakify(self)
    [self.requestViewModelOKSubject subscribeNext:^(NSArray *  _Nullable array) {
        @strongify(self);
        NSNumber * requestTag = [array objectAtIndex:0];
        NSString * requestString = [array objectAtIndex:1];
        NSDictionary * requestDict = [LKCustomMethods dictionaryWithJsonString:requestString];
        if ([requestTag integerValue] == 1) {
            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                [self.dataArray removeAllObjects];
                LKCollectionSectionObject * sectionObject = [[LKCollectionSectionObject alloc]init];
                NSArray *dataArray =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]];
                sectionObject.itemArray = [LKUrlPictureModel mj_objectArrayWithKeyValuesArray:dataArray];
                [self.dataArray addObject:sectionObject];
                
                NSMutableDictionary*dict = [[NSMutableDictionary alloc]init];
                [dict setObject:@(sectionObject.itemArray.count) forKey:@"dataCount"];
                [dict setObject:@"mainViewRolad" forKey:@"type"];

                [self.cellClickSubject sendNext:dict];
                
                
            }else{
                
                [LKCustomMethods showWindowMessage:[requestDict stringForKey:@"msg"]];
            }
        }else if ([requestTag integerValue] == 2){
            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                DLog(@"%@",requestString);
                [self.cellClickSubject sendNext:@"deleteImageOK"];
            }else{
                
                [LKCustomMethods showWindowMessage:[requestDict stringForKey:@"msg"]];
            }
        }
    }];
    [self.requestViewModelErrorSubject subscribeNext:^(id  _Nullable x) {
        //
        [self.cellClickSubject sendNext:@"netError"];

        
    }];

}

-(NSInteger)selectImagesCount
{
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:0];

    NSInteger count = 0;
    for(LKUrlPictureModel * m in sectionObject.itemArray){
        
        if (m.isSelect) {
            count ++ ;
        }
    }
    return count;
}


//#pragma collect delegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    LKPictureCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LKPictureCell" forIndexPath:indexPath];
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    LKUrlPictureModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
    
    
    cell.picImageView.image = [UIImage imageNamed:LKPicture_Default];

    if (self.isEndDecelerating) {
       
        [cell conFigCellwithData:model atIndex:indexPath];
    }
    if(self.selectCell){
        cell.selectBtn.hidden = NO;
    }else{
        cell.selectBtn.hidden = YES;
    }
    
    WS(weakSelf)
    cell.pictureSelectBtnClick = ^(NSString * _Nonnull status) {

        model.isSelect = !model.isSelect;
        [sectionObject.itemArray replaceObjectAtIndex:indexPath.row withObject:model];
        //判断是否全部选择
        BOOL isSelectAll = YES;
        for(LKUrlPictureModel * m in sectionObject.itemArray){
            if (isSelectAll == YES && m.isSelect == YES ) {
            }else{
                isSelectAll = NO;
            }
        }
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@(isSelectAll) forKey:@"isSelectAll"];
        [dict setObject:@"singImagePress" forKey:@"type"];
        [dict setObject:@([self selectImagesCount]) forKey:@"SelectCount"];

        [weakSelf.cellClickSubject sendNext:dict];

    };
    cell.pictureLongPressClick = ^(NSString * _Nonnull status) {
        if (!weakSelf.selectCell) {
            weakSelf.selectCell = YES;
            [weakSelf.cellClickSubject sendNext:@"longPress"];
        }
    };
    
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (kScreen_Width - 2*6) / 3;
    
    return CGSizeMake(width, width);
    
}

// 设置间距，不设置默认间距比较大，导致一行放不了三个cell

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 6;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    NSMutableDictionary * dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"LookImage" forKey:@"type"];
    [dict setObject:@(indexPath.row) forKey:@"index"];
    NSMutableArray * imagesArray = [[NSMutableArray alloc]init];
    for ( LKUrlPictureModel * model in sectionObject.itemArray) {
        [imagesArray addObject:[NSString stringWithFormat:@"%@%@",LKIconHost,model.url]];
    }
    [dict setObject:imagesArray forKey:@"data"];
         
    [self.cellClickSubject sendNext:dict];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isEndDecelerating = NO;
//    [SDWebImageManager.sharedManager cancelAll];
//    [SDWebImageManager.sharedManager.imageCache clearMemory];
//    [[YYWebImageManager sharedManager].cache.memoryCache removeAllObjects];
    [[YYWebImageManager sharedManager].queue cancelAllOperations];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isEndDecelerating = YES;
    NSArray *visiblePaths = [self.pictureCollectionView indexPathsForVisibleItems];
    [self.pictureCollectionView reloadItemsAtIndexPaths:visiblePaths];
}
@end
