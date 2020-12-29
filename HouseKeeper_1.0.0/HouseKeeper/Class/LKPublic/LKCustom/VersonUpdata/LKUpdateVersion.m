//
//  LKCareTitleView.m
//      
//
//  Created by heshenghui on 2018/3/12.
//

#import "LKUpdateVersion.h"

@implementation LKUpdateVersion

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)titleStr withContent:(NSString *)content withUpdate:(NSString *)update
{
    self = [super init];
    if (self) {
        _titleStr = titleStr;
        _contentStr = content;
        _update = update;
        self.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
        [self conFigUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        
    }
    return self;
}


-(void)conFigUI
{
    
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.picImageView];
    [self.whiteView addSubview:self.titleLabel];
    [self.whiteView addSubview:self.care1Label];
    [self.whiteView addSubview:self.scrollView];
    [self.scrollView addSubview:self.nameLabel];
    [self.whiteView addSubview:self.care2Label];
    self.titleLabel.text = [NSString stringWithFormat:@"最新版本：V%@",_titleStr];

    [self.whiteView addSubview:self.leftBtn];
   
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(268));
        make.height.equalTo(@(354));
        
    }];
  
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.whiteView);
        make.top.equalTo(self.whiteView).offset(-30);
        make.height.equalTo(@(160));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.picImageView.mas_bottom);
        make.left.equalTo(self.picImageView).offset(15);
        make.right.equalTo(self.whiteView).offset(-15);
        make.height.equalTo(@(20));
        
    }];
    [self.care1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.picImageView).offset(15);
        make.right.equalTo(self.whiteView).offset(-15);
        make.height.equalTo(@(20));
        
    }];
    
    CGFloat g = [LKCustomMethods strFitFromheight:_contentStr withFont:_nameLabel.font withWidth:238];
    
    
    
    self.scrollView.frame = CGRectMake(15, 185, 238, 77);
    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.whiteView).offset(15);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
//        make.right.equalTo(self.whiteView).offset(-15);
//        make.height.equalTo(@(77));
//    }];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, g);
    self.nameLabel.frame = CGRectMake(0, 0, 235, g);

//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.scrollView);
//        make.right.equalTo(self.scrollView).offset(-5);
//        make.height.equalTo(@(g));
//    }];
 
    
    
    [self.care2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.scrollView.mas_bottom).offset(4);
        make.left.equalTo(self.picImageView).offset(15);
        make.right.equalTo(self.whiteView).offset(-15);
        make.height.equalTo(@(20));
        
    }];


    if ([_update isEqualToString:@"1"]) {
        
        [_leftBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.backgroundColor =RGBA(255,181,60,1);
        _leftBtn.layer.cornerRadius = 20;
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteView).offset(-15);
            make.left.equalTo(self.whiteView).offset(15);
            make.top.equalTo(self.care2Label.mas_bottom).offset(14);
            make.height.equalTo(@(40));
        }];
    }else{
        
        [self.whiteView addSubview:self.rightBtn];

        
        if([_update isEqualToString:@"2"]){
            [_leftBtn setTitle:@"暂不更新" forState:UIControlStateNormal];

        }else{
            [_leftBtn setTitle:@"不再提示" forState:UIControlStateNormal];

        }
        
        [_leftBtn setTitleColor:RGBA(153,153,153,1) forState:UIControlStateNormal];
        _leftBtn.backgroundColor =[UIColor whiteColor];
        _leftBtn.layer.cornerRadius = 20;
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteView.mas_centerX).offset(-7);
            make.left.equalTo(self.whiteView).offset(15);
            make.top.equalTo(self.care2Label.mas_bottom).offset(14);
            make.height.equalTo(@(40));
        }];
        
        [_rightBtn setTitle:@"更新" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.backgroundColor =RGBA(255,181,60,1);
        _rightBtn.layer.cornerRadius = 20;
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteView).offset(-15);
            make.left.equalTo(self.whiteView.mas_centerX).offset(7);
            make.top.equalTo(self.care2Label.mas_bottom).offset(14);
            make.height.equalTo(@(40));
            
        }];
        
    }
}


-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)dismiss
{
    [self removeFromSuperview];
}

//lazy
-(UIView *)whiteView
{
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        _whiteView.userInteractionEnabled = YES;
        [_whiteView addGestureRecognizer:tap];
        _whiteView.layer.cornerRadius = 7;
        
    }
    return _whiteView;
}

-(UIImageView *)picImageView
{
    
    //268*160
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
        _picImageView.image = [UIImage imageNamed:@"alert view_img_update"];
    }
    return _picImageView;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"";
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        

    }
    return _titleLabel;
}
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = _contentStr;
        _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _nameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
-(UILabel *)care1Label
{
    if (_care1Label == nil) {
        _care1Label = [[UILabel alloc]init];
        _care1Label.text = @"新版特性：";
        _care1Label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _care1Label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        

    }
    return _care1Label;
}


-(UILabel *)care2Label
{
    if (_care2Label == nil) {
        _care2Label = [[UILabel alloc]init];
        _care2Label.text =  @"为避免影响您的使用请立即升级！";
        _care2Label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _care2Label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        
    }
    return _care2Label;
}


-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];

        
    }
    return _scrollView;
}

-(UIButton *)leftBtn
{
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        [_leftBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.backgroundColor =RGBA(255,181,60,1);
        _leftBtn.layer.cornerRadius = 20;
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
        
    }
    return _leftBtn;
}

-(UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        [_rightBtn setTitleColor:[UIColor colorWithRed:245/255.0 green:166/255.0 blue:35/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _rightBtn;
}

-(void)leftBtnClick
{
    if (_careLeftClick) {
        _careLeftClick(_update);
    }
    [self dismiss];
    
}
-(void)rightBtnClick
{
    if (_careRightClick) {
        _careRightClick(_update);
    }
    [self dismiss];
    
}
@end
