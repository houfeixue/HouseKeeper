//
//  LKBaseCollectionViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewCell.h"

@implementation LKBaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupViews];
    }
    return self;
}
//重写view
- (void)_setupViews {
    
    
}

//重写
-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    
}
@end
