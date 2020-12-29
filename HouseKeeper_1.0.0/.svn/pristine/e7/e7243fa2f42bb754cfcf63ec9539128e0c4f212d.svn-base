//
//  LKEvaluationPictureView.m
//      
//
//  Created by sunny on 2018/6/22.
//

#import "LKEvaluationPictureView.h"
#import "LKEvaluationPicturePlaceholderView.h"

@interface LKEvaluationPictureView ()
@property (nonatomic, strong) LKEvaluationPicturePlaceholderView *picturePlaceholderView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation LKEvaluationPictureView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pictureImageArray = [NSMutableArray array];
        _pictureViewWidth = (kScreen_Width - 22 )/3.0f;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    [self addSubview:self.picturePlaceholderView];
    [self addSubview:self.imageView];
    [self addSubview:self.deleteBtn];
    
    self.picturePlaceholderView.frame = CGRectMake(3, 5, self.picturePlaceholderView.placeholderViewWidth, self.picturePlaceholderView.placeholderViewWidth);
    self.imageView.frame = CGRectMake(3, 5, self.picturePlaceholderView.placeholderViewWidth, self.picturePlaceholderView.placeholderViewWidth);
    self.deleteBtn.frame = CGRectMake(self.pictureViewWidth - 21, 1, 20, 20);
    self.deleteBtn.hidden = YES;
}
- (void)setIndex:(NSInteger)index {
    _index = index;
    self.picturePlaceholderView.index = index;
}
- (void)setSelectImage:(UIImage *)selectImage {
    _selectImage = selectImage;
    self.imageView.image = _selectImage;
    if (selectImage == nil) {
        self.deleteBtn.hidden = YES;
        self.picturePlaceholderView.hidden = NO;
    }else {
        self.deleteBtn.hidden = NO;
        self.picturePlaceholderView.hidden = YES;
    }
}
/** action */
- (void)deleteButtonClick {
    if ([self.delegate respondsToSelector:@selector(LKEvaluationPictureViewDelegateDelete:pictureView:)]) {
        [self.delegate LKEvaluationPictureViewDelegateDelete:self.index pictureView:self];
    }
}
- (void)imageViewTap {
    
    if ([self.delegate respondsToSelector:@selector(LKEvaluationPictureViewDelegateTap:pictureView:)]) {
        [self.delegate LKEvaluationPictureViewDelegateTap:self.index pictureView:self];
    }
}

/** lazy */
- (LKEvaluationPicturePlaceholderView *)picturePlaceholderView {
    if (_picturePlaceholderView == nil) {
        _picturePlaceholderView = [[LKEvaluationPicturePlaceholderView alloc] init];
    }
    return _picturePlaceholderView;
}
- (UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"renovation_icon_close"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}
@end
