//
//  LKTableSectionObject.m
//  demo
//
//  Created by lh on 17/2/21.
//  Copyright © 2017年 HLK. All rights reserved.
//

#import "LKTableSectionObject.h"

@implementation LKTableSectionObject
-(NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
}
@end
