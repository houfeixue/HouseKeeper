//
//  LKPictureActionVIew.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureActionVIew.h"

@implementation LKPictureActionVIew

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
        self.backgroundColor =  [UIColor colorWithRed:66/255.0 green:65/255.0 blue:82/255.0 alpha:1/1.0];;
        [self _setUpUIView];
    }
    return self;
}

-(void)_setUpUIView
{
    [self addSubview:self.upLoadBtn];
    [self addSubview:self.moveBtn];
    [self addSubview:self.deleteBtn];
    
    
    [self.upLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(self).dividedBy(3);
        make.height.equalTo(@(20));
    }];
    
    [self.moveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(self).dividedBy(3);
        make.height.equalTo(@(20));
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(self).dividedBy(3);
        make.height.equalTo(@(20));
    }];
    
    
    [self.moveBtn borderForColor:[UIColor whiteColor] borderWidth:1 borderType:UIBorderSideTypeLeft|UIBorderSideTypeRight ];

}

//lazy
-(UIButton *)upLoadBtn
{
    if (_upLoadBtn == nil) {
        _upLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_upLoadBtn setTitle:@"一键上传" forState:UIControlStateNormal];
        _upLoadBtn.titleLabel.font = LK_14font;
        @weakify(self)
        [[_upLoadBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            
            if (self.pictureActionClick) {
                self.pictureActionClick(@"upLoad");
            }

        }];
    }
    return _upLoadBtn;
    
}

-(UIButton *)moveBtn
{
    if (_moveBtn == nil) {
        _moveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moveBtn setTitle:@"移动到" forState:UIControlStateNormal];
        _moveBtn.titleLabel.font = LK_14font;
        @weakify(self)
        [[_moveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            
            if (self.pictureActionClick) {
                self.pictureActionClick(@"move");
            }
            
        }];
    }
    return _moveBtn;
    
}

-(UIButton *)deleteBtn
{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = LK_14font;
        @weakify(self)
        [[_deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            
            if (self.pictureActionClick) {
                self.pictureActionClick(@"delete");
            }
            
        }];
    }
    return _deleteBtn;
    
}

@end
