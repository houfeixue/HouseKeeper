//
//  LKPicturesViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewModel.h"

@interface LKSelectPicturesViewModel : LKBaseCollectionViewModel

@property (nonatomic, strong) NSNumber *categoryId;//类别ID
@property (nonatomic, strong) NSString *actionType;//功能 //delete 删除

@property (nonatomic, assign) NSInteger selectCount;

@end
