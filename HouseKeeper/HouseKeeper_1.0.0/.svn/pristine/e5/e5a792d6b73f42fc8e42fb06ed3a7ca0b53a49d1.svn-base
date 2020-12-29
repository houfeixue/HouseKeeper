//
//  LKPictureViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureViewModel.h"
#import "LKPictureCell.h"
#import "LKPictureSelectModel.h"

@implementation LKPictureViewModel
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
    [[RACObserve(self,categoryId)ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        LKCollectionSectionObject *  section = [[LKCollectionSectionObject alloc]init];

        section.itemArray  =  [NSMutableArray arrayWithArray:[[LKPictureDBManager shareManager]fetchAllAlumbName:self.categoryId]];
        section.itemArray = [[section.itemArray reverseObjectEnumerator] allObjects];
        
        
        //todo 处理数据
        [self.dataArray addObject:section];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        
        [dict setObject:@(section.itemArray.count) forKey:@"Count"];
        [dict setObject:@"CollectReload" forKey:@"type"];

        [self.cellClickSubject sendNext:dict];

        
    }];
    
    
    [[RACObserve(self,isSelectAll)skip:1]subscribeNext:^(id  _Nullable x) {
        @strongify(self)

        NSLog(@"%d",self.isSelectAll);
         LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:0];
        for (int i=0; i<sectionObject.itemArray.count; i++) {
            LKPictureSelectModel * model = [sectionObject.itemArray objectAtIndex:i];
            model.isSelect = self.isSelectAll;
        }
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"SelectAll" forKey:@"type"];
        [dict setObject:@(sectionObject.itemArray.count) forKey:@"count"];

        [self.cellClickSubject sendNext:dict];
        
    }];
    
    [[RACObserve(self,sure)skip:1]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"upload" forKey:@"type"];
        [dict setObject:[self getSlelectImage] forKey:@"data"];
        [self.cellClickSubject sendNext:dict];
        
    }];

    
}

-(NSMutableArray * )getSlelectImage
{
    
    NSMutableArray * selectImages = [[NSMutableArray alloc]init];
    
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:0];
    for (int i=0; i<sectionObject.itemArray.count; i++) {
        LKPictureSelectModel * model = [sectionObject.itemArray objectAtIndex:i];

        if (model.isSelect ) {
            [selectImages addObject:model];
        }

    }
    return selectImages;
}

-(void)requestData{

}

//#pragma collect delegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    LKPictureCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LKPictureCell" forIndexPath:indexPath];
    
    
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    LKPictureSelectModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
    [cell conFigCellwithData:model atIndex:indexPath];
    WS(weakSelf)
    cell.pictureSelectBtnClick = ^(NSString * _Nonnull status) {
        
        
        model.isSelect = !model.isSelect;
        [sectionObject.itemArray replaceObjectAtIndex:indexPath.row withObject:model];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"SelectImage" forKey:@"type"];
        
        NSMutableArray * dataArray = [self getSlelectImage];
        [dict setObject:@(dataArray.count) forKey:@"count"];
        if (dataArray.count == sectionObject.itemArray.count) {
            [dict setObject:@(YES) forKey:@"isSelectAll"];

        }else{
            [dict setObject:@(NO) forKey:@"isSelectAll"];

        }
        
        
        [weakSelf.cellClickSubject sendNext:dict];
        
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
    
    DLog(@"%ld --%ld",indexPath.row ,indexPath.section);

}
@end
