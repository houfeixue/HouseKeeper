//
//  LKAuthorViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/23.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAuthorViewController.h"
#import "LKRegisterPerfectInformationVC.h"


@interface LKAuthorViewController ()

@property(nonatomic,copy)NSString * authorType;
@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UILabel * authorLabel;
@property(nonatomic,strong)UIButton * authorBtn;
@property(nonatomic,strong)YYLabel * tipLabel;


@end

@implementation LKAuthorViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWhiteBackground];
    [self addBlackBackButton];
}
-(instancetype)initAuthorType:(NSString *)type//1成功 ；2.失败
{
    self = [super init];
    if (self) {
        self.authorType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self conFigUI];
    [self updateUI];
}

-(void)conFigUI{
    
    [self addNavBarTitleView];
    //ui
    [self.view addSubview:self.picImageView];
    [self.view addSubview:self.authorLabel];
    [self.view addSubview:self.authorBtn];
    [self.view addSubview:self.tipLabel];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@(160));
        make.top.equalTo(self.view).offset(38);

    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LKLeftMargin);
        make.right.equalTo(self.view).offset(LKRightMargin);
        make.top.equalTo(self.picImageView.mas_bottom).offset(20);
    }];
    
    [self.authorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LKLeftMargin);
        make.right.equalTo(self.view).offset(LKRightMargin);
        make.height.equalTo(@(50));
        make.top.greaterThanOrEqualTo(self.authorLabel.mas_bottom).offset(80);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LKLeftMargin);
        make.right.equalTo(self.view).offset(LKRightMargin);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(12);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).inset(12);
        }
    }];
}
- (void)updateUI {
    self.authorBtn.layer.cornerRadius = 5.0f;
    if ([LKCustomTool isBlankString:self.auditFailDescription] == NO) {
        self.authorLabel.attributedText = [NSString getAttributeStringWithLabelText:@"审核失败" font:LK_20font textColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] changeText:[NSString stringWithFormat:@"\n\n%@",self.auditFailDescription] changeFont:LK_16font changeColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]];
    }
    @weakify(self);
    [[self.authorBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if ([self.authorType isEqualToString:@"1"]) { /// 提交审核
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if ([self.authorType isEqualToString:@"2"]) { /// 审核失败
            LKRegisterPerfectInformationVC *vc = [[LKRegisterPerfectInformationVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    NSString *phone = @"400-898-2888";
    NSString *tipText =  @"如需加急处理请联系";
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",tipText,phone]];
    attribute.yy_font = LK_14font;
    attribute.yy_color = LKLightGrayColor;
    [attribute yy_setTextHighlightRange:NSMakeRange(tipText.length, phone.length) color:LKRedColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        DLog(@"%@",phone);
    }];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    attribute.yy_paragraphStyle = paragraph;
    self.tipLabel.attributedText = attribute;
}
- (void)backAction:(id)sender {
    if ([self.authorType isEqualToString:@"1"]) { /// 提交审核
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if ([self.authorType isEqualToString:@"2"]) { /// 审核失败
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [super backAction:sender];
    }
}
//lazy
-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
        
        if ([self.authorType isEqualToString:@"1"]) {
            _picImageView.image = [UIImage imageNamed:@"commitOK"];

        }else if ([self.authorType isEqualToString:@"2"]){
            _picImageView.image = [UIImage imageNamed:@"commitError"];

        }
    }
    return _picImageView;
}
- (void)addNavBarTitleView {
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_3"]];
    self.navigationItem.titleView = titleView;
}
-(UILabel *)authorLabel{
    if (_authorLabel == nil) {
        _authorLabel = [[UILabel alloc]init];
        _authorLabel.numberOfLines = 0;
        _authorLabel.textAlignment = NSTextAlignmentCenter;
        
        if ([self.authorType isEqualToString:@"1"]) {
            _authorLabel.attributedText = [NSString getAttributeStringWithLabelText:@"提交成功" font:LK_20font textColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] changeText:@"\n\n您的申请正在审核请耐心等待" changeFont:LK_16font changeColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]];
        }else if ([self.authorType isEqualToString:@"2"]){
           _authorLabel.attributedText = [NSString getAttributeStringWithLabelText:@"审核失败" font:LK_20font textColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] changeText:@"\n\n您输入的信息有误，请重新认证" changeFont:LK_16font changeColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]];
        }
    }
    return _authorLabel;
}


-(UIButton *)authorBtn
{
    if (_authorBtn == nil) {
        _authorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if ([self.authorType isEqualToString:@"1"]) {
            _authorBtn.backgroundColor = [UIColor colorWithRed:66/255.0 green:65/255.0 blue:82/255.0 alpha:1/1.0];
            [_authorBtn setTitle:@"知道了" forState:UIControlStateNormal];
            
        }else if ([self.authorType isEqualToString:@"2"]){
            _authorBtn.backgroundColor = [UIColor colorWithRed:66/255.0 green:65/255.0 blue:82/255.0 alpha:1/1.0];
            [_authorBtn setTitle:@"重新认证" forState:UIControlStateNormal];
        }
    }
    return _authorBtn;
}

- (YYLabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[YYLabel alloc] init];
    }
    return _tipLabel;
}
@end
