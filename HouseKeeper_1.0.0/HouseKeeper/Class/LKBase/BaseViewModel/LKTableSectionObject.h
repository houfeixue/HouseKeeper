//
//  LKTableSectionObject.h
//  demo
//
//  Created by lh on 17/2/21.
//  Copyright © 2017年 HLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKTableSectionObject : NSObject
@property(nonatomic,strong)NSMutableArray *itemArray;//senction数据
@property(nonatomic,copy)NSString * sectionKey;//区别Section
@property (nonatomic, assign) long long sectionValue;//

@end
