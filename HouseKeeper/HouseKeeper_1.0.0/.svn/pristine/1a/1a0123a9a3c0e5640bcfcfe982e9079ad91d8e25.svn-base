//
//  LKLocationManager.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Dialog.h"


@class LKLocationModel;

@interface LKLocationManager : NSObject<CLLocationManagerDelegate>
LKSingletonH(LKLocationManager)
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 初始化locationManager */
+ (void)getResposeLocation:(void(^)(LKLocationModel *locationModel)) locationResult;
//- (instancetype)initWithResposeLocation:(void(^)(LKLocationModel *locationModel)) locationResult ;

@end


@interface LKLocationModel: NSObject

@property (nonatomic, strong) CLLocation *currentLocation;
/** 经度 */
@property (nonatomic, assign) CLLocationDegrees longitude;
/** 纬度 */
@property (nonatomic, assign) CLLocationDegrees latitude;
/** 当前城市 */
@property (nonatomic, copy) NSString *currentCity;
/** 当前的位置 */
@property (nonatomic, copy) NSString *subLocality;
/** 当前街道 */
@property (nonatomic, copy) NSString *thoroughfare;
/** 具体地址 */
@property (nonatomic, copy) NSString *name;


@end

