//
//  LKAddPictureItemView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@class LKPictureModel,LKAddPictureView;

@protocol LKAddPictureItemViewDelegate <NSObject>
/** 高度改变 */
- (void)LKAddPictureItemViewDelegateViewHeight:(CGFloat)pictureViewHeight;

/** 选择照片，index是第几个照片 */
- (void)LKAddPictureItemViewDelegateSelectPictureIndex:(NSInteger)pictureIndex;
/** 删除照片 */
- (void)LKAddPictureItemViewDelegatetureDeletePicture:(NSInteger)pictureIndex;

@optional
- (void)LKAddPictureItemViewDelegatetureCheckBigPicture:(NSInteger)pictureIndex pictureView:(LKAddPictureView *)pictureView imageArray:(NSMutableArray *)imageArray;


@end

@interface LKAddPictureItemView : LKBaseView
/** 图片model数组 */
@property (nonatomic, strong) NSMutableArray<LKPictureModel *> *pictureArray;
/** 图片view数组 */
@property (nonatomic, strong) NSMutableArray *pictureViewArray;

/** view高度 */
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, weak) id<LKAddPictureItemViewDelegate> delegate;

@property (nonatomic, assign) BOOL isAllowLongPressShowDeleteBtn;

@property (nonatomic, strong) UIView *pictureBgView;

/** 隐藏删除按钮 */
- (void)hiddenPictureDeteleBtn;
- (void)showPictureDeteleBtn;
- (void)reRefreshPictureView;
- (void)bindPictureData:(NSMutableArray *)pictureArray titleName:(NSString *)titleName;
@end
