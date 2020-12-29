//
//  LKPictureBottomView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDProgressView.h"

typedef void(^UpLoadLoadClick)(NSString * status);
typedef void(^UpLoadLoadOKClick)(NSString * status);


@interface LKPictureBottomView : UIView


@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * uploadBtn;
@property(nonatomic,strong)UIButton * cancelBtn;

@property(nonatomic,strong)LDProgressView * progressView;
@property(nonatomic,copy)NSNumber * detailId;

@property(nonatomic,copy)UpLoadLoadClick upLoadLoadClick;
@property(nonatomic,copy)UpLoadLoadOKClick upLoadLoadOKClick;


@end
