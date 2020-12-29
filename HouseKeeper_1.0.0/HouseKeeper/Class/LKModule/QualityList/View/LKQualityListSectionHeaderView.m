//
//  LKQualityListSectionHeaderView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityListSectionHeaderView.h"

@implementation LKQualityListSectionHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupView];
    }
    return self;
}

-(void)_setupView
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.picImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.isFoldBtn];
    [self addSubview:self.progressView];
    [self addSubview:self.lookBtn];
    [self addSubview:self.uploadBtn];
    [self addSubview:self.progressLabel];
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.width.height.equalTo(@(20));
        make.top.equalTo(self).offset(18);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(LKRightMargin);
        make.top.equalTo(self).offset(18);
        make.width.equalTo(@(50));
        make.height.equalTo(@(20));
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scoreLabel.mas_left).offset(-5);
        make.top.equalTo(self).offset(18);
        make.left.equalTo(self.picImageView.mas_right).offset(12);
        make.height.equalTo(@(20));
    }];
    
    [self.isFoldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(LKRightMargin);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
        make.left.equalTo(self).offset(LKLeftMargin);
        make.right.equalTo(self.isFoldBtn.mas_left).offset(0);
        make.height.equalTo(@(20));

    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.top.equalTo(self.isFoldBtn.mas_bottom).offset(14);
        make.width.equalTo(@(kScreen_Width - 2*LKLeftMargin));
        make.height.equalTo(@(4));
    }];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.bottom.equalTo(self.progressView.mas_top).offset(-2);
    }];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.top.equalTo(self.isFoldBtn.mas_bottom).offset(20);
        make.width.equalTo(@(kScreen_Width/2));
        make.height.equalTo(@(40));
    }];
    
    [self.lookBtn borderForColor:LKF7Color borderWidth:1 borderType:UIBorderSideTypeTop|UIBorderSideTypeRight];

    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self.isFoldBtn.mas_bottom).offset(20);
        make.width.equalTo(@(kScreen_Width/2));
        make.height.equalTo(@(40));
    }];
    [self.uploadBtn borderForColor:LKF7Color borderWidth:1 borderType:UIBorderSideTypeTop];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUpLoadNotion) name:LKImageUploadOKNotiation object:nil];

    
}
-(void)checkUpLoadNotion
{
    NSArray * imageArray = [LKCustomMethods getUpLoadImagesCountFromCategoryId:_selectModel.detailId];
    _detailLabel.attributedText = [self getDetailText:@"已上传" withCount:[NSString stringWithFormat:@"%@",_selectModel.imgNumber]];

    
    NSInteger upLoadImageCount=0;
    for (int i=0; i<imageArray.count; i++) {
        LKUpLoadPictureModel * model = [imageArray objectAtIndex:i];
        if (model.upLoad) {
            upLoadImageCount ++;
        }
    }
    
    if (upLoadImageCount == imageArray.count) {
        
        //上传完成
        self.progressView.progress = 1;
        self.progressView.hidden = YES;
        self.progressLabel.text = @"100%";
        self.progressLabel.hidden = YES;
        _detailLabel.attributedText = [self getDetailText:@"已上传" withCount:[NSString stringWithFormat:@"%@",_selectModel.imgNumber]];
        
        if (upLoadImageCount!=0) {
            if (_qualityUpLoadClick) {
                _qualityUpLoadClick(@"");
            }
        }else{
        }
    
    }else{
        //正在完成
        self.progressView.hidden = NO;

        self.progressView.progress = (CGFloat)upLoadImageCount/imageArray.count;
        self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", self.progressView.progress*100];
        self.progressLabel.hidden = NO;
        DLog(@"上传完成  进度 ：%lf",self.progressView.progress);
        
        _detailLabel.attributedText = [NSString getAttributeStringWithLabelText:[NSString stringWithFormat:@"%lu",imageArray.count - upLoadImageCount] font:LK_14font textColor:LKBlueColor changeText:@" 张待传 " changeFont:LK_14font changeColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0]];
    }
}
//lazy
-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
//        _picImageView.image = [UIImage imageNamed:@"check_icon_car"];
    }
    return _picImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"客服基础服务";
        _nameLabel.font = LK_medium_18font;//[UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _nameLabel.textColor = LKBlackColor;


    }
    return _nameLabel;
}
-(UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = LK_14font;

    }
    return _detailLabel;
}
-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.text = @"16分";
        _scoreLabel.font = LK_medium_16font;[UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _scoreLabel.textColor = LKBlackColor;
        _scoreLabel.textAlignment = NSTextAlignmentRight;
    }
    return _scoreLabel;
}

-(UIButton *)isFoldBtn{
    if(_isFoldBtn == nil ){
        _isFoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_isFoldBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_isFoldBtn setImage:[UIImage imageNamed:@"check_icon_down_blue"] forState:UIControlStateNormal];
        [_isFoldBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20) withImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [_isFoldBtn setTitleColor:[UIColor colorWithRed:82/255.0 green:113/255.0 blue:141/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        _isFoldBtn.titleLabel.font = LK_14font;
        @weakify(self)
        [[_isFoldBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.qualityBtnClick) {
                self.qualityBtnClick(@"isFold");
            }
        }];
    }
    return _isFoldBtn;
}
- (UILabel *)progressLabel {
    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.textColor = LKCrownColor;
        _progressLabel.font = LK_9font;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.hidden = YES;
    }
    return _progressLabel;
}
-(LDProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[LDProgressView alloc]init];
        _progressView.showBackgroundInnerShadow = @NO;
        _progressView.hidden = YES;
        _progressView.showText = @NO;
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

-(UIButton *)lookBtn
{
    if(_lookBtn == nil ){
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookBtn setTitle:@"查看照片" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:LKBlueColor forState:UIControlStateNormal];
        _lookBtn.titleLabel.font = LK_14font;
        
        @weakify(self)
        [[_lookBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.qualityBtnClick) {
                self.qualityBtnClick(@"look");
            }
        }];
    }
    return _lookBtn;
}
-(UIButton *)uploadBtn
{
    if(_uploadBtn == nil ){
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uploadBtn setTitle:@"上传照片" forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:LKBlueColor forState:UIControlStateNormal];
        _uploadBtn.titleLabel.font = LK_14font;
        @weakify(self)
        [[_uploadBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.qualityBtnClick) {
                self.qualityBtnClick(@"upload");
            }
        }];
    }
    return _uploadBtn;
}

-(void)setViewUIWithModel:(LKQualityListModel*)model
{
    _selectModel = model;
    _nameLabel.text = model.ruleInfo;
    _scoreLabel.text = [NSString stringWithFormat:@"%@分",model.fullMark];
    NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LKIconHost,model.iconUrl]];
    [_picImageView yy_setImageWithURL:imageUrl placeholder:[UIImage imageNamed:LKPicture_Default]];
    
    if (model.isShow) {
        [_isFoldBtn setTitle:@"收起" forState:UIControlStateNormal];
        [_isFoldBtn setImage:[UIImage imageNamed:@"check_icon_up_blue"]forState:UIControlStateNormal];
    }else{
        
        [_isFoldBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_isFoldBtn setImage:[UIImage imageNamed:@"check_icon_down_blue"]forState:UIControlStateNormal];
    }
//    //初始化
    [self checkUpLoad];
    
}


-(void)checkUpLoad
{
    NSArray * imageArray = [LKCustomMethods getUpLoadImagesCountFromCategoryId:_selectModel.detailId];
//    _detailLabel.text = [NSString stringWithFormat:@"已上传 %@ 张  %lu 张待传",_selectModel.imgNumber,(unsigned long)imageArray.count];
    
    _detailLabel.attributedText = [self getDetailText:@"已上传" withCount:[NSString stringWithFormat:@"%@",_selectModel.imgNumber]];

    NSInteger upLoadImageCount=0;
    for (int i=0; i<imageArray.count; i++) {
        LKUpLoadPictureModel * model = [imageArray objectAtIndex:i];
        if (model.upLoad) {
            upLoadImageCount ++;
        }
    }
    
    if (upLoadImageCount == imageArray.count) {
        //上传完成
        self.progressView.progress = 1;
        self.progressView.hidden = YES;
        self.progressLabel.text = @"100%";
        self.progressLabel.hidden = YES;
        _detailLabel.attributedText = [self getDetailText:@"已上传" withCount:[NSString stringWithFormat:@"%@",_selectModel.imgNumber]];
    }else{
        //正在完成
        self.progressView.hidden = NO;
        
        self.progressView.progress = (CGFloat)upLoadImageCount/imageArray.count;
        self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", self.progressView.progress*100];
        self.progressLabel.hidden = NO;

        DLog(@"上传完成  进度 ：%lf",self.progressView.progress);
        
        _detailLabel.attributedText = [NSString getAttributeStringWithLabelText:[NSString stringWithFormat:@"%lu",imageArray.count - upLoadImageCount] font:LK_14font textColor:LKBlueColor changeText:@" 张待传 " changeFont:LK_14font changeColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0]];

    }
}


-(NSMutableAttributedString * )getDetailText:(NSString *)text withCount:(NSString *)count
{
    NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:text];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0],};
    [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
    
    NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ",count]];
    
    NSDictionary * secondAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:LKBlueColor,};
    [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
    
    [firstPart appendAttributedString:secondPart];
    
    NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"张"]];
    
    NSDictionary * thirdAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0],};
    [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
    [firstPart appendAttributedString:thirdPart];

    return firstPart;
    
}

@end
