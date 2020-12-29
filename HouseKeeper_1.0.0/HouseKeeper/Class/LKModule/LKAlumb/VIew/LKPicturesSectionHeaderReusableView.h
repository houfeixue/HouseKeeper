//
//  LKPicHeaderReusableView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PicturesClick)(NSInteger status);


@interface LKPicturesSectionHeaderReusableView : UICollectionReusableView
{
    
    NSInteger _select; //0 选择 1 全选 2取消选择
}

@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * selectLabel;
@property(nonatomic,copy)PicturesClick picturesClick;

-(void)conDataTime:(NSString *)time withSelect:(NSInteger )select;

@end
