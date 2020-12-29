//
//  LKSearchBar.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchBar.h"


@interface LKSearchBar ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIImageView *leftImageView;
@end

@implementation LKSearchBar

- (void)createUI {
    [super createUI];
    self.layer.cornerRadius = 13.0f;
    self.layer.masksToBounds = YES;
    [self addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.with.mas_equalTo(16);
    }];
    [self.leftImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).inset(8);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
    }];
    [self addGestureRecognizer:self.tapGesture];
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _searchTextField.placeholder = _placeholder;
}
- (void)setInputHidden:(BOOL)inputHidden {
    _inputHidden = inputHidden;
    self.searchTextField.enabled = !inputHidden;
    
}
- (void)tapClick {
    if (self.inputHidden) {
        if (self.toSearch != nil) {
            self.toSearch();
        }
    }
}
- (UITextField *)searchTextField {
    if (_searchTextField == nil) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.font = LK_15font;
        _searchTextField.textColor = LKGrayColor;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_searchTextField setValue:LKDisableGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.tintColor = LKGrayColor;
    }
    return _searchTextField;
}
- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    }
    return _tapGesture;
}
- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.image = [UIImage imageNamed:@"search_icon_search"];
    }
    return _leftImageView;
}

@end
