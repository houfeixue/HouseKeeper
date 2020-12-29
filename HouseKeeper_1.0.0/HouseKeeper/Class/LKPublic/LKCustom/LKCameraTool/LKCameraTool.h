//
//  LKCameraTool.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LKCameraToolGetPicture)(NSMutableDictionary *);

@interface LKCameraTool : NSObject
LKSingletonH(LKCameraTool)
@property (nonatomic, copy) LKCameraToolGetPicture pictureHandle;
- (void)showPickerController:(UIViewController *)vc pictureHandle:(LKCameraToolGetPicture)pictureHandle;
@end
