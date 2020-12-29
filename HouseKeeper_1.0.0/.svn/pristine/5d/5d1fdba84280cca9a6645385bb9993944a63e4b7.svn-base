//
//  HQPickerView.h
//  HQPickerView
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 judian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HQPickerViewDelegate <NSObject>

- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSInteger )num;

@end

@interface HQPickerView : UIView

@property (nonatomic, strong) NSArray *customArr;
@property (nonatomic, weak) id <HQPickerViewDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;;

@end
