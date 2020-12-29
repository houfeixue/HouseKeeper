//
//  LKPictureBottomView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureBottomView.h"
#import "LKPIctureUploadManager.h"
@implementation LKPictureBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LKF2Color;
        [self _setUpView];
    }
    
    return self;
}

-(void)_setUpView
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.uploadBtn];
    [self addSubview:self.progressView];
    [self addSubview:self.cancelBtn];

    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(LKRightMargin);
        make.height.equalTo(@(30));
        make.width.equalTo(@(45));

    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(LKLeftMargin);
        make.right.equalTo(self.uploadBtn.mas_left);
        make.height.equalTo(@(30));
        
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(LKLeftMargin);
        make.right.equalTo(self.uploadBtn.mas_left).offset(LKRightMargin);
        make.height.equalTo(@(15));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(LKRightMargin);
        make.height.equalTo(@(30));
        make.width.equalTo(@(45));
        
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUpLoadNotion) name:LKImageUploadOKNotiation object:nil];
    
}

-(void)checkUpLoadNotion
{
//    BOOL user_IsCancelUpLoad = [UserDefaultsHelper getBoolForKey:LKUser_IsCancelUpLoad];
//    if (user_IsCancelUpLoad) {
//        return;
//    }
    
    NSArray * imageArray =[LKCustomMethods getUpLoadImagesCountFromCategoryId:self.detailId];
    NSInteger upLoadImageCount=0;
    for (int i=0; i<imageArray.count; i++) {
        LKUpLoadPictureModel * model = [imageArray objectAtIndex:i];
        if (model.upLoad) {
            upLoadImageCount ++;
        }
    }
    
    if (upLoadImageCount == imageArray.count) {
        //上传完成
        self.cancelBtn.hidden = NO;
        self.uploadBtn.hidden = YES;
        
        self.progressView.progress = 1;
        self.progressView.hidden = YES;
        [self.progressView overrideProgressText:[NSString stringWithFormat:@"%lu 张待传 ",imageArray.count - upLoadImageCount]];

        _nameLabel.text = [NSString stringWithFormat:@"当前%lu张照片待上传 ",imageArray.count - upLoadImageCount];
        if (_upLoadLoadOKClick) {
            _upLoadLoadOKClick(@"");
        }
        
    }else{
        //正在完成
        self.cancelBtn.hidden = NO;
        self.uploadBtn.hidden = YES;
        self.progressView.hidden = NO;
        self.progressView.progress = (CGFloat )upLoadImageCount/imageArray.count;
        DLog(@"self.progressView.progress  : %lf",self.progressView.progress);
        
        [self.progressView overrideProgressText:[NSString stringWithFormat:@"%lu 张待传 ",imageArray.count - upLoadImageCount]];
        _nameLabel.text = [NSString stringWithFormat:@"%lu 张待传 ",imageArray.count - upLoadImageCount];
        if (self.progressView.progress == 0) {
            _nameLabel.hidden = NO;
        }else{
            _nameLabel.hidden = YES;

        }
    }
    
    BOOL user_IsCancelUpLoad = [UserDefaultsHelper getBoolForKey:LKUser_IsCancelUpLoad];
    if (user_IsCancelUpLoad ) {
        self.nameLabel.hidden = NO;
        self.progressView.hidden = YES;
        self.cancelBtn.hidden = YES;
        self.uploadBtn.hidden = NO;
    }


}

-(void)setDetailId:(NSNumber *)detailId
{
    _detailId = detailId;
    [self checkUpLoadNotion];
}

//lazy
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"";
        _nameLabel.font = LK_12font;
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];

    }
    return _nameLabel;
}
-(UIButton *)uploadBtn
{
    if (_uploadBtn == nil) {
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
        _uploadBtn.titleLabel.font = LK_12font;;
        [_uploadBtn setTitleColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        _uploadBtn.backgroundColor = [UIColor colorWithRed:66/255.0 green:65/255.0 blue:82/255.0 alpha:1/1.0];
        [_uploadBtn hyb_addCornerRadius:5];
        
        @weakify(self);
        
        [[_uploadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            
//            if(self.upLoadLoadClick){
//                self.upLoadLoadClick(@"");
//            }

            [UserDefaultsHelper setBoolForKey:NO :LKUser_IsCancelUpLoad];
            [[LKPIctureUploadManager shareInstance] startUpLoadimage];
            self.nameLabel.hidden = YES;
            self.progressView.hidden = NO;
            self.cancelBtn.hidden = NO;
            self.uploadBtn.hidden = YES;
            [self checkUpLoadNotion];

        }];
        
    }
    return _uploadBtn;
}

-(UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"暂停" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = LK_12font;;
        [_cancelBtn setTitleColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        _cancelBtn.hidden = YES;
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [UserDefaultsHelper setBoolForKey:YES :LKUser_IsCancelUpLoad];

            self.nameLabel.hidden = NO;
            self.progressView.hidden = YES;
            self.cancelBtn.hidden = YES;
            self.uploadBtn.hidden = NO;

        }];
        
        
    }
    
    return _cancelBtn;
}

-(LDProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[LDProgressView alloc]init];
        _progressView.showBackgroundInnerShadow = @NO;
        _progressView.hidden = YES;
        _progressView.textAlignment = NSTextAlignmentCenter;
        _progressView.color = LKGrayColor;
        _progressView.flat = @YES;
        _progressView.progress = 0.0;
        _progressView.animate = @NO;
        _progressView.showStroke = @NO;
        _progressView.progressInset = @0.3;
        _progressView.showBackground = @NO;
        _progressView.outerStrokeWidth = @0.3;
        _progressView.type = LDProgressSolid;

        
    }
    return _progressView;
}
@end
