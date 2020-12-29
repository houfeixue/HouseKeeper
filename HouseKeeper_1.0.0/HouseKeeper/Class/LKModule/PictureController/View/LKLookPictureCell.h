//
//  LKPictureCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^PictureSelectBtnClick)(NSString * status);
typedef void(^PictureLongPressClick)(NSString * status);


@interface LKLookPictureCell : LKBaseCollectionViewCell


@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UIButton * selectBtn;;

@property(nonatomic,copy)PictureSelectBtnClick pictureSelectBtnClick;
@property(nonatomic,copy)PictureLongPressClick pictureLongPressClick;


@end

NS_ASSUME_NONNULL_END
