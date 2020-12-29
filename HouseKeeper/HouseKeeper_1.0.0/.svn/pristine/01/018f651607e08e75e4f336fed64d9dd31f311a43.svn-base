//
//  LKAddWorkDescriptionItemView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"
#import "UITextView+WZB.h"

@protocol LKAddWorkDescriptionItemViewDelegate <NSObject>
/** textView高度改变 */
- (void)LKAddWorkDescriptionItemViewDelegateViewHeight:(CGFloat)viewHeight;

@end

@interface LKAddWorkDescriptionItemView : LKBaseView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, weak) id<LKAddWorkDescriptionItemViewDelegate> delegate;
- (void)bindWorkDescriptionData:(NSString *)workDesc;
@end
