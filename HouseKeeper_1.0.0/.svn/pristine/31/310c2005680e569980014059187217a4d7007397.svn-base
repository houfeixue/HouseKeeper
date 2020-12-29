//
//  LKEvaluationPictureView.h
//      
//
//  Created by sunny on 2018/6/22.
//

#import <UIKit/UIKit.h>

@class LKEvaluationPictureView;

@protocol LKEvaluationPictureViewDelegate <NSObject>
- (void)LKEvaluationPictureViewDelegateDelete:(NSInteger)index pictureView:(LKEvaluationPictureView *)pictureView;
- (void)LKEvaluationPictureViewDelegateTap:(NSInteger)index pictureView:(LKEvaluationPictureView *)pictureView;

@end

@interface LKEvaluationPictureView : UIView

@property (nonatomic, strong) NSMutableArray *pictureImageArray;
/** 设置选中的iamge */
@property (nonatomic, strong) UIImage *selectImage;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat pictureViewWidth;
@property (nonatomic, assign) id<LKEvaluationPictureViewDelegate> delegate;
@end
