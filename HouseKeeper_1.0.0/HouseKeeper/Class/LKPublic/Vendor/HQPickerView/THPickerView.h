//
//  THPickerView.h
//  test
//
//  Created by 童浩 on 2017/1/6.
//  Copyright © 2017年 童小浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_cancelButtonColor [UIColor blackColor] //取消按钮颜色
#define k_confirmButtonColor [UIColor blackColor] //确定按钮颜色
#define k_confirmButtonNotClickColor [UIColor blackColor] //滑动时确认按钮不可点击颜色
@interface THPickerView : UIView
/*
    数据格式如递归取值的比如
 [
	{
        "name":"A",
        "ID":001,
        "data":
            [
                {
                    "name":"A1",
                    "ID":003,
                    "data":
                        [
                            {
                                "name":"A1A",
                                "ID":006
                            }
                        ]
                },
                {
                    "name":"A2",
                    "ID":005
                }
            ]
	},
	{
        "name":"B",
        "ID":002,
        "data":
            [
                {
                    "name":"B1",
                    "ID":004
                }
            ]
	}
 ]
 这样的数据DataKey 就是数据里对应的二级的Key "data"
 dataArray 就是数组数据
 而testKey就是要显示的 数据里对应的 key "name"
 numberOfComponents 就是几层级 这里数据最多3级就是 3
 PS:这样的数据后台直接给过来就最好了一定要回这样的数据解析
*/
- (instancetype)initWithDataKey:(NSString *)key AndDataArray:(NSArray *)dataArray AndTestKey:(NSString *)testKey AndNumberOfComponents:(NSInteger)numberOfComponents;
//回调数组是几级分类的第几个 比如数组0位输出字符串2就代表第一排数据选中的是第二个 以此类推最后还是自己要数据解析哦
- (void)showConfirmBlock:(void (^)(NSArray<NSString *> *indexArray))block;
@property (nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)UILabel * titleLabel;
@end
