//
//  LKPictureCliassifyView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PictureCliassifyClick)(NSString * status);

@interface LKPictureCliassifyView : UIView

@property(nonatomic,strong)UILabel * classifyBtn;
@property(nonatomic,strong)UIButton * uploadBtn;
@property (nonatomic, strong) UIView *lineView;
@property(nonatomic,copy)PictureCliassifyClick pictureClassifyClick;

-(void)conFigClassifyName:(NSString *)text;

@end
