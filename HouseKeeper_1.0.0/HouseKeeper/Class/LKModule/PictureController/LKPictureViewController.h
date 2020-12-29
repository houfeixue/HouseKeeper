//
//  LKPictureViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewController.h"
#import "LKQualityListModel.h"

@interface LKPictureViewController : LKBaseCollectionViewController

@property(nonatomic,copy)NSString * type;//look : 查看照片， upload ：上传照片

@property(nonatomic,strong)NSNumber * categoryId; //相册ID
@property(nonatomic,copy)NSString * name;//相册name
@property(nonatomic,strong) LKQualityListModel * qualityModel;
@property(nonatomic,strong) NSNumber * commityId;//小区ID


@end
