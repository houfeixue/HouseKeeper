//
//  THPickerView.m
//  test
//
//  Created by 童浩 on 2017/1/6.
//  Copyright © 2017年 童小浩. All rights reserved.
//

#import "THPickerView.h"
#define k_timers 0.25
#define k_mainSize [UIScreen mainScreen].bounds.size
#define k_OnePx (k_mainSize.width / 750.0)
@interface THPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong)NSString *dataKay;
@property (nonatomic,strong)UIView *picRootView;
@property (nonatomic,strong)UIButton *quxiaoButton;
@property (nonatomic,strong)UIButton *quedingButton;
@property (nonatomic,strong)UIColor *biankuangColor;
@property (nonatomic,strong)UIView *view;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic,assign)BOOL is_gundong;
@property (nonatomic,assign)NSInteger numberOfComponents;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)NSString *testKey;
@property (nonatomic,strong)NSMutableDictionary *DataRowDic;
@property (nonatomic,strong)void (^block)(NSArray<NSString *> *);
@end

@implementation THPickerView
- (instancetype)initWithDataKey:(NSString *)key AndDataArray:(NSArray *)dataArray AndTestKey:(NSString *)testKey AndNumberOfComponents:(NSInteger)numberOfComponents{
    if (self = [super init]) {
        self.block = nil;
        self.frame = CGRectMake(0, 0, k_mainSize.width, k_mainSize.height);
        _biankuangColor = RGBA(205, 205, 205, 1);
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,k_mainSize.width, k_mainSize.height)];
        _view.backgroundColor = [UIColor blackColor];
        _view.alpha = 0;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
        [_view addGestureRecognizer:tapGesture];
        [self addSubview:_view];
        self.backgroundColor = [UIColor clearColor];
        _picRootView = [[UIView alloc]initWithFrame:CGRectMake(0, k_mainSize.height, k_mainSize.width, 520 * k_OnePx)];
        _picRootView.backgroundColor = [UIColor whiteColor];
        _quxiaoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _quxiaoButton.frame = CGRectMake(0, 0, 160 * k_OnePx, 80 * k_OnePx);
        [_quxiaoButton setTitle:@"取消" forState:UIControlStateNormal];
        [_quxiaoButton setTitleColor:k_cancelButtonColor forState:UIControlStateNormal];
        _quxiaoButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _quxiaoButton.backgroundColor= RGBA(246, 246, 246, 0.9);

        [_quxiaoButton addTarget:self action:@selector(event:) forControlEvents:UIControlEventTouchUpInside];
        [_picRootView addSubview:_quxiaoButton];
        _quedingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _quedingButton.frame = CGRectMake(k_mainSize.width - 160 * k_OnePx, 0, 160 * k_OnePx, 80 * k_OnePx);
        [_quedingButton setTitle:@"确定" forState:UIControlStateNormal];
        [_quedingButton setTitleColor:k_confirmButtonColor forState:UIControlStateNormal];
        
        _quedingButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_quedingButton addTarget:self action:@selector(querenAction) forControlEvents:UIControlEventTouchUpInside];
        [_picRootView addSubview:_quedingButton];
        _quedingButton.backgroundColor= RGBA(246, 246, 246, 0.9);
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.backgroundColor = RGBA(246, 246, 246, 0.9);
        [_picRootView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.quxiaoButton.mas_right);
            make.right.equalTo(self.quedingButton.mas_left);
            make.top.equalTo(self.quxiaoButton);
            make.bottom.equalTo(self.quxiaoButton);
            
        }];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(k_OnePx, 80 * k_OnePx, k_mainSize.width - 2 * k_OnePx, _picRootView.frame.size.height - 80 * k_OnePx)];
        //是否要显示选中的指示器(默认值是NO)
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _timer = [NSTimer scheduledTimerWithTimeInterval:k_timers target:self selector:@selector(andTimeAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        self.is_gundong = YES;
        _picRootView.backgroundColor = [UIColor whiteColor];
        [_picRootView addSubview:_pickerView];
        [self addSubview:_picRootView];
        _numberOfComponents = numberOfComponents;
        self.testKey = testKey;
        self.dataArray = dataArray;
        self.dataKay = key;
        self.DataRowDic = [NSMutableDictionary dictionary];
        for (NSInteger i = 0; i < _numberOfComponents; i++) {
            NSString *numberStr = [NSString stringWithFormat:@"%ld",i];
            [self.DataRowDic setObject:@"0" forKey:numberStr];
        }
    }
    return self;
}
- (void)event:(UIView *)view {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.frame.size.height);
        self.picRootView.frame = CGRectMake(0,self.frame.size.height, self.picRootView.frame.size.width, self.picRootView.frame.size.height);
    } completion:^(BOOL finished) {
        [self andTimeAction];
        [self removeFromSuperview];
    }];
}
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self donghuaAction];
}
- (void)donghuaAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.3;
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.frame.size.height - 520 * k_OnePx);
        self.picRootView.frame = CGRectMake(0,self.frame.size.height - 520 * k_OnePx, self.picRootView.frame.size.width, self.picRootView.frame.size.height);
    }];
}
- (void)andTimeAction {
    [_timer invalidate];
    _timer = nil;
    self.is_gundong = YES;
}
- (void)setIs_gundong:(BOOL)is_gundong {
    _is_gundong = is_gundong;
    if (_is_gundong) {
        _quedingButton.userInteractionEnabled = YES;
        [_quedingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else {
        _quedingButton.userInteractionEnabled = NO;
        [_quedingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (void)querenAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.frame.size.height);
        self.picRootView.frame = CGRectMake(0,self.frame.size.height, self.picRootView.frame.size.width, self.picRootView.frame.size.height);
    } completion:^(BOOL finished) {
        [self andTimeAction];
        if (self.block) {
            NSMutableArray *arrays = [NSMutableArray array];
            for (NSInteger i = 0; i < self.numberOfComponents; i++) {
                [arrays addObject:self.DataRowDic[[NSString stringWithFormat:@"%ld",i]]];
            }
            self.block(arrays);
        }
        [self removeFromSuperview];
    }];
}
- (void)showConfirmBlock:(void (^)(NSArray<NSString *> *indexArray))block {
    self.block = block;
    self.DataRowDic = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < _numberOfComponents; i++) {
        NSString *numberStr = [NSString stringWithFormat:@"%ld",i];
        NSInteger rowAndI = [self.pickerView selectedRowInComponent:i];
        [self.DataRowDic setObject:[NSString stringWithFormat:@"%ld",(long)rowAndI] forKey:numberStr];
    }
    [self show];
}
#pragma UIPickerViewDelegate And UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.numberOfComponents;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *array = self.dataArray;
    for (NSInteger i = 0; i < _numberOfComponents; i++) {
        if (component == 0) {
            return array.count;
        }else {
            if (i - 1 >= 0) {
                NSString *str = self.DataRowDic[[NSString stringWithFormat:@"%ld",i - 1]];
                NSDictionary *dic = array[[str integerValue]];
                array = dic[self.dataKay];
            }
            if (i == component) {
                return array.count;
            }
        }
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    //#warning ~~~
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:k_timers target:self selector:@selector(andTimeAction) userInfo:nil repeats:YES];
    }else {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:k_timers]];
    }
    if (self.is_gundong) {
        self.is_gundong = NO;
    }
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    for (UIView *view in _pickerView.subviews) {
        if (view.frame.size.height < 2) {
            
            
            // 205  224
            NSLog(@"view.frame.size.height %@ : %lf ",view,view.frame.size.height );
            if (view.frame.origin.y>100) {
                view.backgroundColor = RGBA(224, 224, 224, 1);


            }else{
                view.backgroundColor = _biankuangColor;

            }
            
        }
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *numberStr = [NSString stringWithFormat:@"%ld",component];
    NSString *rowStr = [NSString stringWithFormat:@"%ld",row];
    for (NSInteger i = 0; i < _numberOfComponents; i++) {
        NSInteger rowAndI = [_pickerView selectedRowInComponent:i];
        NSString *numberStra = [NSString stringWithFormat:@"%ld",i];
        NSString *rowStra = [NSString stringWithFormat:@"%ld",rowAndI];
        [self.DataRowDic setObject:rowStra forKey:numberStra];
    }
    [self.DataRowDic setObject:rowStr forKey:numberStr];
    NSInteger i = component + 1;
    while (i < _numberOfComponents) {
        NSString *numberStras = [NSString stringWithFormat:@"%ld",i];
        [self.DataRowDic setObject:@"0" forKey:numberStras];
        [pickerView reloadComponent:i];
        [pickerView selectRow:0 inComponent:i animated:NO];
        i++;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *array = self.dataArray;
    for (NSInteger i = 0; i < _numberOfComponents; i++) {
        if (component == 0) {
            id s = array[row];
            if ([s isKindOfClass:[NSString class]]) {
                return s;
            }
            
            NSDictionary *dic = array[row];
            return dic[self.testKey];
        }else {
            if (i - 1 >= 0) {
                NSString *str = self.DataRowDic[[NSString stringWithFormat:@"%ld",i - 1]];
                NSDictionary *dic = array[[str integerValue]];
                array = dic[self.dataKay];
            }
            if (i == component) {
                NSDictionary *dics = array[row];
                return dics[self.testKey];
            }
            
        }
    }
    return @"数据错误";
}
@end
