//
//  LKSelectCityListView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectCityListView.h"
#import "LKSelectCityCell.h"
#import "LKCitysModel.h"

@interface LKSelectCityListView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LKSelectCityListView
- (void)createUI {
    [super createUI];
    self.layer.borderColor = LKDisableGrayColor.CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0, 0.5f);
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)bindData:(NSMutableArray *)array {
    self.cityDataArray = array;
    [self.tableView reloadData];
}
#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LKSelectCityCell * cell = [LKSelectCityCell cellForTableView:tableView reuseIdentifier:@"LKSelectCityCell"];
    LKCityModel *cityModel = [self.cityDataArray objectAtIndex:indexPath.row];
    cell.cityNameLabel.text = cityModel.name;
    if (cityModel.isSelected == YES) {
        cell.cityNameLabel.textColor = LKLightRedColor;
    }else {
        cell.cityNameLabel.textColor = LKLightGrayColor;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectCity = [self.cityDataArray objectAtIndex:indexPath.row];
    for (NSInteger i = 0; i < self.cityDataArray.count; i ++ ) {
        LKCityModel *tempModel = [self.cityDataArray objectAtIndex:i];
        tempModel.isSelected = NO;
        if ([self.selectCity.cityId isEqualToNumber:tempModel.cityId]) {
            tempModel.isSelected = YES;
        }
    }
    [self.tableView reloadData];
    if (self.selectCityClick) {
        self.selectCityClick(self.selectCity);
    }
}
//lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[LKSelectCityCell class] forCellReuseIdentifier:@"LKSelectCityCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 50.f;
    }
    return _tableView;
}
- (NSMutableArray *)cityDataArray {
    if (_cityDataArray == nil) {
        _cityDataArray = [NSMutableArray array];
    }
    return _cityDataArray;
}
@end
