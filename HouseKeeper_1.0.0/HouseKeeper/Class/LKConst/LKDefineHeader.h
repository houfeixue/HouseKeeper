//
//  LKDefineHeader.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/11.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#ifndef LKDefineHeader_h
#define LKDefineHeader_h


//升级提醒
#define LKAppStore @"LKAppStore"
#define LKVersion @"Version"

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//颜色值
#define LKBlackColor  [ColorUtil colorWithHex:@"#424152"] //主色
#define LKCrownColor  [ColorUtil colorWithHex:@"#52718D"]
#define LKLightGreenColor  [ColorUtil colorWithHex:@"#41A3AC"]
#define LKLightRedColor  [ColorUtil colorWithHex:@"#C06163"]
#define LKRedColor  [ColorUtil colorWithHex:@"#C06163"]
#define LKBlueColor  [ColorUtil colorWithHex:@"#52718D"]
#define LKF7Color  [ColorUtil colorWithHex:@"#F7F7F7"]
#define LKF2Color  [ColorUtil colorWithHex:@"#F2F2F2"]
#define LK99Color  [ColorUtil colorWithHex:@"#999999"]
#define LKLightGrayColor  [ColorUtil colorWithHex:@"#666666"]
#define LKGrayColor  [ColorUtil colorWithHex:@"#333333"]
#define LKDisableGrayColor  [ColorUtil colorWithHex:@"#CCCCCC"]
#define LKDisableBtnColor  [ColorUtil colorWithHex:@"#D8D8D8"]

#define LKLineColor  [ColorUtil colorWithHex:@"#E9E9E9"]

#define RGBA(r,g,b,a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//左右边距
#define LKLeftMargin   12
#define LKRightMargin   -12



//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


//NSUserDefault
#define LKNetWorksStatus @"NetWorksStatus" //网络状态
#define LKUpLoadImageArrays @"UpLoadImageArrays" // 图片上传存储
#define LKUpLoadImageNetStatus @"UpLoadImageNetStatus" // 用户支持网络上传的模式 1： WIFT 模式  ；2：有网模式



//数据库路径
#define LKUserInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserInfo.plist"] // 用户信息

#define LKPhotoAlbumoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PhotoAlbum.db"] //本地相册

#define LKPicturePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Picture"] //本地原图片

#define LKShrinkPicturePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ShrinkPicture"] //本地缩小图片

#define LKCompoundPicturePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CompoundPicture"] //本地合成图片


#define LKPersonMessagePath   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"PersonMessaList.plist"]//本地消息列表



//通知
#define LKNetStatusNotiation  @"NetStatusNotiation"

#define LKTakePhotoSucessNotiation  @"TakePhotoSucessNotiation"

#define LKDeletePhotoSucessNotiation  @"DeletePhotoSucessNotiation"//工作相册图片删除通知
#define LKMovePhotoSucessNotiation  @"MovePhotoSucessNotiation"//工作相册图片移动通知
#define LKImageUploadOKNotiation   @"ImageUploadOKNotiation" //图片上传成功通知


//userdefault
#define LKUser_Alumb @"User_Alumb" //用户相册

#define LKUser_LatestVersion @"User_LatestVersion" //最新版本

#define LKUser_IsCancelUpLoad @"User_IsCancelUpLoad" //是否取消上传

#define LKUser_FirstOpen @"User_FirstOpen" //用户第一次打开

//默认图片
#define LKPicture_Default @"photo_default"

//网络还在缩略图
#define LKNetShrinkPic_Default @"_150x150.png"



/** 表情相关 */
// 表情的最大行数
#define SDFaceMaxRows 3
// 表情的最大列数
#define SDFaceMaxCols 7
// 每页最多显示多少个表情
#define SDFaceMaxCountPerPage (SDFaceMaxRows * SDFaceMaxCols - 1)

#endif /* LKDefineHeader_h */
