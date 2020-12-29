//
//  LKPictureActionVIew.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PictureActionClick)(NSString * status);

@interface LKPictureActionVIew : UIView

@property(nonatomic,strong)UIButton * upLoadBtn;//一键上传
@property(nonatomic,strong)UIButton * moveBtn;//移动到
@property(nonatomic,strong)UIButton * deleteBtn;//删除到
@property(nonatomic,copy)PictureActionClick pictureActionClick;//删除到

@end
