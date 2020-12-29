//
//  LKEvaluationPicturePlaceholderView.m
//      
//
//  Created by sunny on 2018/6/22.
//

#import "LKEvaluationPicturePlaceholderView.h"

@interface LKEvaluationPicturePlaceholderView ()
@property (nonatomic, strong) UIImageView *cameraImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation LKEvaluationPicturePlaceholderView

- (instancetype)init
{
    self = [super init];
    if (self) {
         /** left = 3 right = 5 */
        self.placeholderViewWidth = (kScreen_Width - 22 )/3.0f - 8;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    self.bounds = CGRectMake(0, 0, self.placeholderViewWidth, self.placeholderViewWidth);
    [self addBordeDashLine];
    [self addSubview:self.cameraImageView];
    [self addSubview:self.tipLabel];
    [self.cameraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-6);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(28);
    }];
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.right.equalTo(self.mas_right).inset(2);
        make.top.equalTo(self.cameraImageView.mas_bottom).offset(6);
    }];
    self.index = 0;
}
- (void)setIndex:(NSInteger)index {
    _index = index;
    if (_index == 0) {
        [self.cameraImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.tipLabel.text = nil;
    }else {
        self.tipLabel.text = [NSString stringWithFormat:@"%ld/6",(long)_index];
    }
}
- (void)addBordeDashLine {
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [RGBA(153, 153, 153, 1) CGColor];
    border.fillColor = [[UIColor clearColor] CGColor];
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = 0.6f;
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:border];
}


- (UIImageView *)cameraImageView {
    if (_cameraImageView == nil) {
        _cameraImageView = [[UIImageView alloc] init];
        _cameraImageView.image = [UIImage imageNamed:@"renovation_icon_camera"];
    }
    return _cameraImageView;
}
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _tipLabel.textColor = RGBA(153, 153, 153, 1);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}
@end
