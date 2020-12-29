//
//  LKPersonEditVc.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPersonEditVc.h"
#import "LKPersonMessageEditViewModel.h"
#import "LKPersonMessageFirstCell.h"

@interface LKPersonEditVc ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) LKPersonMessageEditViewModel *viewModel;
@property(nonatomic,strong)  NSString * imageString;;

@end

@implementation LKPersonEditVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle = @"个人信息";
    [self addRightNavButtonWithTitle:@"保存" action:@selector(rightNavBtnClick)];
    self.viewModel.messageModel = self.messageModel;
    self.mainTableView.delegate = self.viewModel;
    self.mainTableView.dataSource = self.viewModel;
    self.mainTableView.backgroundColor = LKF2Color;
    [self.mainTableView reloadData];
    
    WS(weakSelf);
    self.viewModel.LKPersonMessageEditViewModel = ^(NSIndexPath *index) {
        DLog(@"选择照片");
        [weakSelf photoAction];
    };
  
    [self.viewModel.successDataSubject subscribeNext:^(id x) {
        /// 取出数据
         [LKCustomMethods showWindowMessage:@"信息保存成功"];
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0];     
    }];
    
}

-(void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击
-(void)rightNavBtnClick
{
    [self.view endEditing:YES];
    DLog(@"个人信息保存");
    NSIndexPath * index1 = [NSIndexPath indexPathForRow:0 inSection:2];
    LKPersonMessageFirstCell *cell= [self.mainTableView cellForRowAtIndexPath:index1];
    
    NSIndexPath * index2 = [NSIndexPath indexPathForRow:1 inSection:2];
    LKPersonMessageFirstCell *cell2= [self.mainTableView cellForRowAtIndexPath:index2];
    

    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(model.userId) forKey:@"customerId"];
    if (self.imageString) {
      [params setObject:self.imageString forKey:@"portrait"];
    }else{
        [params setObject:self.messageModel.portrait forKey:@"portrait"];
    }
    
    [params setObject:model.mobile forKey:@"mobile"];
    [params setObject:cell.valueTextFiled.text forKey:@"workPalace"];
    [params setObject:cell2.valueTextFiled.text forKey:@"customerCode"];
    self.viewModel.requestUrl = LKUpdateUserInfo;
    self.viewModel.requestTag = 1;
    self.viewModel.requestDict = params;
    
}


#pragma mark - 照片选择
-(void)photoAction
{
    WS(weakSelf);
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    [cancle setValue:LKRedColor forKey:@"titleTextColor"];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [ [LKCameraTool sharedLKCameraTool]showPickerController:weakSelf pictureHandle:^(NSMutableDictionary * dict) {
            DLog(@"%@",dict);
            [self upLoadImage:[dict objectForKey:@"currentImage"]];
        }];
        
    }];
    [camera setValue:LKGrayColor forKey:@"titleTextColor"];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //调用系统相册的类
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        
        //设置选取的照片是否可编辑
        pickerController.allowsEditing = YES;
        //设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
        //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
        pickerController.delegate = weakSelf;
        //使用模态呈现相册
        [weakSelf.navigationController presentViewController:pickerController animated:YES completion:^{
            
        }];
        
    }];
    [picture setValue:LKGrayColor forKey:@"titleTextColor"];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [weakSelf presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark -拍照
// 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self upLoadImage:image];
        
    }
}
// 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)upLoadImage:(UIImage *)image
{
    NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"app",@"sign", nil];
    [LKCustomMethods showMBMBHUBView:self.view];
    [LKHttpImageRequest uploadImageWithPath:LKUploadimg image:image params:dict success:^(id Json) {
        [LKCustomMethods hideMBMBHUBView:self.view];
        NSArray *data =  [LKCustomMethods objectWithJsonString:[LKEntcry decryptAES:[Json objectForKey:@"data"]]];
        DLog(@"%@",data);
        self.imageString = [NSString stringWithFormat:@"%@",data[0]];
        NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
        LKPersonMessageFirstCell *cell= [self.mainTableView cellForRowAtIndexPath:index];

        if ([data[0] containsString:@"group"]) {
            NSString *urltring = [NSString stringWithFormat:@"%@%@",LKIconHost,data[0]];
            [cell.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:cell.personImageView.image];
        }else{
            NSString *urltring = [NSString stringWithFormat:@"%@%@",LKPHPIconHost,data[0]];
            [cell.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:cell.personImageView.image];
        }
        
        
    } failure:^{
        [LKCustomMethods hideMBMBHUBView:self.view];
    }];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNavigationTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LKPersonMessageEditViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[LKPersonMessageEditViewModel alloc] init];
    }
    return _viewModel;
}

@end
