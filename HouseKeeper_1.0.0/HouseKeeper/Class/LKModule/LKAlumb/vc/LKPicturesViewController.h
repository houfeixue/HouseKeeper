//
//  LKPicturesViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewController.h"

@interface LKPicturesViewController : LKBaseCollectionViewController

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSNumber * categoryId;

@property(nonatomic,strong)LKAlumbModel * alumbModel;



@end
