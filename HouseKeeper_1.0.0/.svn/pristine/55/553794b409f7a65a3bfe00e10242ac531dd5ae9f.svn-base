//
//  LKSelectListView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectListClick)(LKAlumbModel * model);

@interface LKSelectClassityListView : UIView<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,copy) NSString * type;//1 : 拍照  //2移动
@property(nonatomic,copy) NSNumber * currentAlumbId;//当前Id


@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)SelectListClick selectListClick;
@property(nonatomic,strong)NSMutableArray *  dataArray;
-(instancetype)initWithType:(NSString *)type;

@end
