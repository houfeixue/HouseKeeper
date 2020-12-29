//
//  LKPicturesViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectPicturesViewModel.h"
#import "LKPictureCell.h"
#import "LKPictureModel.h"
#import "LKPicturesSectionHeaderReusableView.h"
@implementation LKSelectPicturesViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    
    @weakify(self)
    [[RACObserve(self,categoryId)ignore:nil] subscribeNext:^(NSDictionary * requestDict) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        NSArray * picArray =  [NSMutableArray arrayWithArray:[[LKPictureDBManager shareManager]fetchAllAlumbName:[self.categoryId stringValue]]];
        
        NSArray *ageSortResultArray = [picArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            LKPictureModel *per1 = obj1;
            LKPictureModel *per2 = obj2; 
            if ([per1.timeStr isEqualToString:per2.timeStr] == NSOrderedDescending ) {
                return NSOrderedAscending;//降序
            }else{
                return NSOrderedSame;
            }

        }];
        NSString * timeStr = @"";
        LKCollectionSectionObject * section ;
        ageSortResultArray =[NSMutableArray arrayWithArray: [[ageSortResultArray reverseObjectEnumerator] allObjects]];

        for (int i=0; i<ageSortResultArray.count; i++) {
            LKPictureModel *picModel = [ageSortResultArray objectAtIndex:i];
            if (![picModel.timeStr isEqualToString:timeStr]) {
                if (![timeStr isEqualToString:@""]) {
                    [self.dataArray addObject:section];
                }
                timeStr = picModel.timeStr;
                section = [[LKCollectionSectionObject alloc]init];

            }
            
            [section.itemArray addObject:picModel];
        }
        
        //todo 处理数据
        [self.dataArray addObject:section];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"allCount" forKey:@"type"];
        [dict setObject:@(section.itemArray.count) forKey:@"data"];
        
        [self.cellClickSubject sendNext:dict];
        
    }];
    
    [[RACObserve(self,actionType)ignore:nil]subscribeNext:^(id _Nullable x) {
        @strongify(self)

        if ([self.actionType isEqualToString:@"delete"]) {
          BOOL isDelete =  [[LKPictureDBManager shareManager] deleteDataWithAlumbName:[self->_categoryId stringValue] withArray:[self selectSelectPicArray]];
            if ( isDelete ) {
                self.categoryId = self.categoryId;
                [[NSNotificationCenter defaultCenter]postNotificationName:LKDeletePhotoSucessNotiation object:nil];
            }
        }else if ([self.actionType isEqualToString:@"move"]){
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:@"move" forKey:@"type"];
            [dict setObject:[self selectSelectPicArray] forKey:@"data"];
            [self.cellClickSubject sendNext:dict];
        }else if ([self.actionType isEqualToString:@"upLoad"]){
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:@"upLoad" forKey:@"type"];
            [dict setObject:[self selectSelectPicArray] forKey:@"data"];
            [self.cellClickSubject sendNext:dict];
        }else if ([self.actionType isEqualToString:@"sureSelectPicS"]){
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:@"sureSelectPicS" forKey:@"type"];
            [dict setObject:[self selectSelectPicArray] forKey:@"data"];
            [self.cellClickSubject sendNext:dict];
        }
        
        
    }];
    
    
}

//选取选择的模型
-(NSMutableArray * )selectSelectPicArray
{
    NSMutableArray * selectArray = [[NSMutableArray alloc]init];
    for (int i=0; i<self.dataArray.count; i++) {
        LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:i];
        for (int j=0; j<sectionObject.itemArray.count; j++) {
            LKPictureModel * model = [sectionObject.itemArray objectAtIndex:j];
            if (model.isSelect) {
                [selectArray addObject:model];
            }
        }
    }
    return selectArray;
}

//选取个数
-(NSInteger )selectPicCount
{
    NSInteger count = 0;
    for (int i=0; i<self.dataArray.count; i++) {
        LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:i];
        for (int j=0; j<sectionObject.itemArray.count; j++) {
            LKPictureModel * model = [sectionObject.itemArray objectAtIndex:j];
            if (model.isSelect) {
                count++;
            }
        }
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"count" forKey:@"type"];
    [dict setObject:@(count) forKey:@"count"];

    [self.cellClickSubject sendNext:dict];
    
    return count;

}

//#pragma collect delegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKPictureCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LKPictureCell" forIndexPath:indexPath];
    
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    LKPictureModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
//    if (sectionObject.sectionValue == 1) {
//        cell.selectBtn.hidden = NO;
//
//    }else{
//        cell.selectBtn.hidden = YES;

//    }
    cell.selectBtn.hidden = NO;

    [cell conFigCellwithData:model atIndex:indexPath];
    WS(weakSelf)
    cell.pictureSelectBtnClick = ^(NSString * _Nonnull status) {
        
        if (weakSelf.selectCount <= [self selectPicCount]) {
            
            
            [LKCustomMethods showWindowMessage:[NSString stringWithFormat:@"最多选取%ld",(long)weakSelf.selectCount]];
            return ;
        }
        
        model.isSelect = !model.isSelect;
        [sectionObject.itemArray replaceObjectAtIndex:indexPath.row withObject:model];
        [weakSelf.cellClickSubject sendNext:@"MainCollectReload"];
        [weakSelf selectPicCount];
    };
    
    cell.pictureLongPressClick = ^(NSString * _Nonnull status) {
        
        DLog(@"pictureLongPressClick");
        sectionObject.sectionValue = 1;
        [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionObject];
        [weakSelf.cellClickSubject sendNext:@"MainCollectReload"];
    };
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = ((kScreen_Width) - 2*6) / 3;
    
    return CGSizeMake(width, width);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LKPicturesSectionHeaderReusableView * headerView =[collectionView dequeueReusableSupplementaryViewOfKind:
                                               UICollectionElementKindSectionHeader withReuseIdentifier:@"LKPicturesSectionHeaderReusableView" forIndexPath:indexPath];
        LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
        headerView.selectLabel.hidden = YES;
        
        if (sectionObject.itemArray.count>0) {
            LKPictureModel * model = [sectionObject.itemArray objectAtIndex:0];
            [headerView conDataTime:model.timeStr withSelect:sectionObject.sectionValue];
            

        }
        WS(weakSelf)
        headerView.picturesClick = ^(NSInteger status) {
            
            sectionObject.sectionValue = status;
            
            if (sectionObject.sectionValue !=1 ) {
                for (int i=0; i<sectionObject.itemArray.count; i++) {
                    LKPictureModel * model = [sectionObject.itemArray objectAtIndex:i];
                    model.isSelect = NO;
                    [sectionObject.itemArray replaceObjectAtIndex:i withObject:model];
                }
            }
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionObject];
            
            [weakSelf.cellClickSubject sendNext:@"MainCollectReload"];

        };
        
        return headerView;
    }
    
    return nil;
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
    
    
    LKCollectionSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    LKPictureModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"updataPicModel" forKey:@"type"];
    [dict setObject:model forKey:@"data"];
    [self.cellClickSubject sendNext:dict];

    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.cellClickSubject sendNext:indexPath];
    
}

@end
