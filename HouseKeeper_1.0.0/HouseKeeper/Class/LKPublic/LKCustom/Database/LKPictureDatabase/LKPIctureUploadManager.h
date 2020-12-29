//
//  LKPIctureUploadManager.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKMergeView.h"

@interface LKPIctureUploadManager : NSObject

+(instancetype) shareInstance ;

@property(nonatomic,strong) LKMergeView * mergeView;

@property(nonatomic,assign) BOOL isSingleUpload; // 确定上传的唯一性

-(void) startUpLoadimage;

@end
