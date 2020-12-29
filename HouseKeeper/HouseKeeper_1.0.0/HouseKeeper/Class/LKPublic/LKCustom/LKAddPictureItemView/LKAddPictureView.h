//
//  LKAddPictureView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@class LKAddPictureView;

@protocol LKAddPictureViewDelegate <NSObject>
- (void)LKAddPictureViewDelegateDelete:(NSInteger)index pictureView:(LKAddPictureView *)pictureView;
- (void)LKAddPictureViewDelegateTap:(NSInteger)index pictureView:(LKAddPictureView *)pictureView;
- (void)LKAddPictureViewLongPress;
@end

@interface LKAddPictureView : LKBaseView

@property (nonatomic, strong) NSMutableArray *pictureImageArray;
/** 设置选中的iamge */
@property (nonatomic, strong) LKPictureModel *selectImageModel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat pictureViewWidth;
@property (nonatomic, weak) id<LKAddPictureViewDelegate> delegate;
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIImageView *imageView;

@end
