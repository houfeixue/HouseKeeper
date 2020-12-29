//
//  LKPicturesViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewController.h"

@protocol LKSelectPicturesViewControllerDelegate <NSObject>
- (void)selectPicturesArray:(NSArray *)imageArray;
@end


@interface LKSelectPicturesViewController : LKBaseCollectionViewController<LKSelectPicturesViewControllerDelegate>

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSNumber * categoryId;

@property(nonatomic,strong)LKAlumbModel * alumbModel;

@property(nonatomic,assign)NSInteger  selectCount;//select 最大数

@property(nonatomic,strong)UIViewController * formVC;//

@property (nonatomic, weak) id <LKSelectPicturesViewControllerDelegate> delegate;

@end
