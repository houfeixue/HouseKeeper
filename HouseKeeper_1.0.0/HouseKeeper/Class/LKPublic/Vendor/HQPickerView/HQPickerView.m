//
//  HQPickerView.m
//  HQPickerView
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 judian. All rights reserved.
//

#import "HQPickerView.h"

/** 屏幕宽高 */
#define kScreenBounds [UIScreen mainScreen].bounds
#define KScreenWidth [[UIScreen mainScreen]bounds].size.width
#define KScreenHeight [[UIScreen mainScreen]bounds].size.height

//RGB
//#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface HQPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *completionBtn;

@property (nonatomic, strong) UIView* line;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSString *selectedStr;

@end

@implementation HQPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        self.backgroundColor = self.backgroundColor = RGBA(0, 0, 0, 0.2);
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 260)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
        
        //显示动画
        [self showAnimation];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn.backgroundColor = RGBA(246, 246, 246, 1);
        [self.bgView addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(44);
        }];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:RGBA(0, 0, 0, 1) forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.completionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.completionBtn.backgroundColor = RGBA(246, 246, 246, 1);

        [self.bgView addSubview:self.completionBtn];
        [self.completionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(44);
        }];
        self.completionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.completionBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.completionBtn setTitleColor:RGBA(0, 0, 0, 1) forState:UIControlStateNormal];
        [self.completionBtn addTarget:self action:@selector(completionBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = RGBA(246, 246, 246, 1);
        [self.bgView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cancelBtn.mas_right);
            make.right.equalTo(self.completionBtn.mas_left);
//            make.left.equalTo(self.bgView);
//            make.right.equalTo(self.bgView);
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(0);
            
        }];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //线
        UIView *line = [UIView new];
        [self.bgView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(KScreenWidth);
            make.height.mas_equalTo(0.5);
            
        }];
        line.backgroundColor = RGBA(224, 224, 224, 1);
        self.line = line ;
    }
    return self;
}


#pragma mark-----UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.customArr.count;
}




- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.customArr[row];
}


//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//
//    //设置分割线的颜色
//    for(UIView *singleLine in pickerView.subviews)
//    {
//        if (singleLine.frame.size.height < 1)
//        {
//            singleLine.backgroundColor = RGBA(0, 0, 0, 0.15);
//        }
//    }
//
//    UILabel * l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    l.text = self.customArr[row];
//    l.font = [UIFont systemFontOfSize:23];
//    l.textAlignment =  NSTextAlignmentCenter;
//    return l;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedStr = self.customArr[row];
}


- (void)setCustomArr:(NSArray *)customArr {
    _customArr = customArr;
    self.pickerView = [UIPickerView new];
    self.pickerView.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:self.pickerView];
    [self.bgView sendSubviewToBack:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.line).offset(-50);
        make.left.right.mas_equalTo(0);
    }];
    self.pickerView.frame = CGRectMake(0, 0, KScreenWidth, 260);
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;

    [self.array addObject:customArr];
}


#pragma mark-----取消
- (void)cancelBtnClick{
    [self hideAnimation];
}

#pragma mark-----取消
- (void)completionBtnClick{
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:didSelectText:)]) {
        [self.delegate pickerView:self.pickerView didSelectText:[self.pickerView selectedRowInComponent:0]];
    }
    [self hideAnimation];
}

#pragma mark-----隐藏的动画
- (void)hideAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = KScreenHeight;
        self.bgView.frame = frame;
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark-----显示的动画
- (void)showAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = KScreenHeight-260;
        self.bgView.frame = frame;
    }];
}

@end
