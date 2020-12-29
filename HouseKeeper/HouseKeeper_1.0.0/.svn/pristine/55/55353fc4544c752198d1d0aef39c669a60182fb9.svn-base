//
//  LKSelectListView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityDetailSelectListView.h"
#import "LKSelectListViewCell.h"
#import "LKQualityDetailModel.h"

@implementation LKQualityDetailSelectListView

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
    [self addSubview:backGroundView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [backGroundView addGestureRecognizer:tap];
    
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.8);
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}


-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc]initWithArray:dataArray];
    [self.tableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKSelectListViewCell * cell = [LKSelectListViewCell cellForTableView:tableView reuseIdentifier:@"LKSelectListViewCell"];
    LKQualityDetailModel * model = [self.dataArray objectAtIndex:indexPath.row];
    cell.separatorView.hidden = NO;
    cell.nameLabel.text = model.categoryName;
    if ([self.selectCommityId isEqualToNumber:model.categoryId]) {
        cell.selectImage.hidden = NO;
    }else{
        
        cell.selectImage.hidden = YES;
    }
    
    if (_selectCommityId == nil && indexPath.row == 0) {
        cell.selectImage.hidden = NO;
    }
    if (indexPath.row == 0) {
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kScreen_Width-20, 0.5)];
        lineview.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [cell.contentView addSubview:lineview];
    }
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectListClick) {
        
        LKQualityDetailModel * model = [self.dataArray objectAtIndex:indexPath.row];
        self.selectListClick(model);
    }
}

@end
