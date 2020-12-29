//
//  LKWorkPicUpLoadViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewController.h"
typedef void(^PictureUploadClick)(NSInteger status);

@interface LKWorkPicUpLoadViewController : LKBaseTableViewController

@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,copy)PictureUploadClick pictureUploadClick;

@end
