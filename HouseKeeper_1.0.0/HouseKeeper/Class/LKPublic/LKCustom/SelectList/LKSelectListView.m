//
//  LKSelectListView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectListView.h"
#import "LKSelectListViewCell.h"

@implementation LKSelectListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self _setUpView];
    }
    return self;
}

-(void)_setUpView
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    UIView * backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.5;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [backGroundView addGestureRecognizer:tap];
    [self addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.8);
    }];
    
    @weakify(self);

    [self.selectViewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:[NSDictionary class]]) {
            @strongify(self)

            NSDictionary * dict = (NSDictionary *)x;
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"reload"]) {
                
                self.dataArray = [LKCommityModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"data"]];
                
                
                [self.tableView reloadData];
                
                if (self.selectListClick) {
                    LKCommityModel * model = [self.dataArray objectAtIndex:0];
                    self.selectListClick(model,self.dataArray.count);
                }
                
            }
        }
    }];
    
}
-(void)hiddenView
{
    [self removeFromSuperview];
}
//lazy
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.alpha = 1;
        [_tableView registerClass:[LKSelectListViewCell class] forCellReuseIdentifier:@"LKSelectListViewCell"];
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

-(LKSelectViewModel *)selectViewModel
{
    if (_selectViewModel == nil) {
        _selectViewModel = [[LKSelectViewModel alloc]init];
    }
    return _selectViewModel;
}
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)setSelectCommityId:(NSNumber *)selectCommityId
{
    _selectCommityId = selectCommityId;
    [self.tableView reloadData];
}
#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKSelectListViewCell * cell = [LKSelectListViewCell cellForTableView:tableView reuseIdentifier:@"LKSelectListViewCell"];
    LKCommityModel * model = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    if ([self.selectCommityId isEqualToNumber:model.Id]) {
        cell.selectImage.hidden = NO;
    }else{
        
        cell.selectImage.hidden = YES;
    }
    
    if (_selectCommityId == nil && indexPath.row == 0) {
        cell.selectImage.hidden = NO;

    }
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectListClick) {
        
        LKCommityModel * model = [self.dataArray objectAtIndex:indexPath.row];
        self.selectListClick(model ,self.dataArray.count);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
