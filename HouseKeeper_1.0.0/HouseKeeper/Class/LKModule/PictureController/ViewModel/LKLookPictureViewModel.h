//
//  LKLookPictureViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/23.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewModel.h"
#import "LKBaseCollectionViewController.h"

@interface LKLookPictureViewModel : LKBaseCollectionViewModel
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数
@property (nonatomic, assign) NSInteger currentIndex;//当前选择那一个



@property (nonatomic, assign) BOOL isEndDecelerating;
@property (nonatomic, strong) UICollectionView *pictureCollectionView;
@end
