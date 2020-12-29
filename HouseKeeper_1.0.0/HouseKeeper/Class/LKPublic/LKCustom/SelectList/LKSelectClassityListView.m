//
//  LKSelectListView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectClassityListView.h"
#import "LKSelectClassifyVIewCell.h"
#import "LKSelectAlumbTableViewCell.h"

@implementation LKSelectClassityListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        self.type = type;
        [self _setUpView];
    }
    return self;
}

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
    backGroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [backGroundView addGestureRecognizer:tap];
    [self addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.8);
    }];
}

-(void)hiddenView
{
    [self removeFromSuperview];
}
-(void)setCurrentAlumbId:(NSNumber *)currentAlumbId
{
    _currentAlumbId = currentAlumbId;
    
    if ([self.type isEqualToString:@"2"]) {
        //移动不显示当前相册
        self.dataArray = [NSMutableArray arrayWithArray:[[LKPictureDBManager shareManager] fetchAlumbData]];
        NSMutableArray * data = [[NSMutableArray alloc]initWithArray:self.dataArray];
        
        for (LKAlumbModel *model in data){
            
            if ([model.categoryId isEqualToNumber:_currentAlumbId]) {
                [self.dataArray removeObject:model];
            }
            
        }
    }
    [self.tableView reloadData];
    
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
        if ([_type isEqualToString:@"1"]) {
            _tableView.rowHeight = 50;

        }else{
            _tableView.rowHeight = 91;

        }
        [_tableView registerClass:[LKSelectClassifyVIewCell class] forCellReuseIdentifier:@"LKSelectClassifyVIewCell"];
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithArray:[[LKPictureDBManager shareManager] fetchAlumbData]];
    }
    return _dataArray;
}



#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_type isEqualToString:@"1"]) {
        //拍照
        
        LKSelectAlumbTableViewCell * cell = [LKSelectAlumbTableViewCell cellForTableView:tableView reuseIdentifier:@"LKSelectAlumbTableViewCell"];
        LKAlumbModel *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.nameLabel.attributedText = [NSString getAttributeStringWithLabelText:model.name font:LK_16font textColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] changeText:@"" changeFont:LK_12font changeColor: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0]];
        if ([model.categoryId longLongValue] == [_currentAlumbId longLongValue]) {
            cell.selectImage.image = [UIImage imageNamed:@"check_icon_selected"];
        }else{
            
            cell.selectImage.image = [UIImage imageNamed:@""];

        }
 
        
        return cell;
    }else{
        LKSelectClassifyVIewCell * cell = [LKSelectClassifyVIewCell cellForTableView:tableView reuseIdentifier:@"LKSelectClassifyVIewCell"];
        LKAlumbModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.nameLabel.attributedText = [NSString getAttributeStringWithLabelText:model.name font:LK_16font textColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] changeText:[NSString stringWithFormat:@"\n%@张",model.count] changeFont:LK_12font changeColor: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0]];
        if ([model.categoryId longLongValue] == [_currentAlumbId longLongValue]) {
            cell.selectImage.image = [UIImage imageNamed:@"check_album_icon_selected"];
        }else{
            
            cell.selectImage.image = [UIImage imageNamed:@""];
            
        }
        NSString * imagePath = [NSString stringWithFormat:@"%@/%@",LKPicturePath,model.pic];
//        cell.picImageView.image = [UIImage imageWithContentsOfFile:imagePath];
//        if (cell.picImageView.image == nil) {
//            cell.picImageView.image = [UIImage imageNamed:LKPicture_Default];
//        }
        [cell.picImageView yy_setImageWithURL:[NSURL fileURLWithPath:imagePath] placeholder:[UIImage imageNamed:LKPicture_Default]];

        return cell;
        
    }
    
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKAlumbModel *model = [self.dataArray objectAtIndex:indexPath.row];

    if (self.selectListClick) {
        self.selectListClick(model);
    }
}

@end
