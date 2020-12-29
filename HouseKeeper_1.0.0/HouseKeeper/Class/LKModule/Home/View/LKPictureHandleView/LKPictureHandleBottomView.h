//
//  LKPictureHandleBottomView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"
#import "LKPictureHandleTextView.h"

typedef void(^LKPictureHandleBottomViewSelectPictureType)(void);

@interface LKPictureHandleBottomView : LKBaseView
@property (nonatomic, strong) LKPictureHandleTextView *textView;
@property (nonatomic, strong) UILabel *selectTypeLabel;

@property (nonatomic, copy) LKPictureHandleBottomViewSelectPictureType selectPictureType;
@end
