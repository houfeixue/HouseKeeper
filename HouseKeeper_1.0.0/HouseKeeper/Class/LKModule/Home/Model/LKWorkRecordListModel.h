//
//  LKWorkRecordListModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKWorkRecordPictureModel;
@class LKPictureModel;

@interface LKWorkRecordListModel : NSObject
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *createTimeM;
/** 工作描述 */
@property (nonatomic, copy) NSString *workDesc;
/** 用户id */
@property (nonatomic, assign) int managerId;
/** 工作记录ID */
@property (nonatomic, assign) int workItemId;
/** 用户身份 1保安 2保洁 3消防 4其他 */
@property (nonatomic, assign) int workType;
/** 地点 */
@property (nonatomic, copy) NSString *workPosition;

@property (nonatomic, strong) NSArray<LKPictureModel *> *urls;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, strong) NSNumber *communityId;


@end


@interface LKWorkRecordPictureModel : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;

@end

