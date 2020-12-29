//
//  LKNet.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#ifndef LKNet_h
#define LKNet_h

//#define LKHostIP                     @"http://10.46.27.80:9090/hopson_manager/"
//**********************正式************************//

#define BaseHost    @"http://dg.aihsh.cn:9090" // 正式环境
#define LKHostIP    @"http://123.56.29.247:9092/"
#define LKIconHost  @"http://file.aihsh.cn/" // icon正式环境
#define LKPHPIconHost  @"http://cimg.aihsh.cn/images/"  // icon正式环境

//**********************正式en d************************//

//**********************测试************************//
//图片上传IP
//#define BaseHost                       @"http://dgtest.aihsh.cn:88" // 测试环境
//#define LKHostIP                       @"http://47.95.196.40:9090/"
//#define LKIconHost                     @"http://filetest.aihsh.cn:9000/" // icon测试环境
//#define LKPHPIconHost  @"http://cimgtest.aihsh.cn/images/"  // icon环境

//**********************测试en d************************//

///** 李志远 */
//#define LKHostIP                     @"http://10.46.27.80:9090/hopson_manager/"

/** 张亚航本地 */
//#define LKHostIP                     @"http://10.46.27.178:8080/"

//#define LKHostIP                     @"http://10.46.27.16:8080/"



//图片上传接口
#define LKUploadimg                    @"/front/interface/upload/imgs"

//版本升级

#define LKGetInfoByVersion             @"hopson_manager/front/app/manager/interface/appVersion/getInfoByVersion"


/************************************ 品质抽查 *************************************/
//App抽查服务
#define LKGetCheckByBrunchId            @"hopson_manager/front/app/manager/interface/spotCheck/getCheckByBrunchId"
/** 抽查记录 */
#define LKSpotCheckCountHistorylist     @"hopson_manager/front/app/manager/interface/spotcheckcount/historylist"
/** 抽查明细 */
#define LKSpotCheckCountDetail          @"hopson_manager/front/app/manager/interface/spotcheckcount/detail"


//查询类别明细
#define LKGetCateGroys                  @"hopson_manager/front/app/manager/interface/spotCheck/getCateGroys"

//根据小区id和身份id获取抽查方案
#define LKGetCheckByBrunchId            @"hopson_manager/front/app/manager/interface/spotCheck/getCheckByBrunchId"

//根据检查id获取明细规则
#define LKGetRuleByCategroyId           @"hopson_manager/front/app/manager/interface/spotCheck/getRuleByCategroyId"

//根据管家id获取小区列表
#define LKGetCommunity                  @"hopson_manager/front/app/manager/interface/spotCheck/getCommunity"

//评分
#define LKSpotCheckSubmit               @"hopson_manager/front/app/manager/interface/spotCheck/submit"


//上传附件列表
#define LKUploadAttchment               @"hopson_manager/front/app/manager/interface/spotCheck/uploadAttchment"

//获取图片信息
#define LKGetAttachments                @"hopson_manager/front/app/manager/interface/spotCheck/getAttachments"
//删除图片
#define LKDeleteAttachments             @"hopson_manager/front/app/manager/interface/spotCheck/deleteAttachments"

//根据标准获取明细信息
#define LKGetRuleInfoById              @"hopson_manager/front/app/manager/interface/spotCheck/getRuleInfoById"

//APP查看抽查照片
#define LKSpotcheckcountImages             @"hopson_manager/front/app/manager/interface/spotcheckcount/images"



/************************************ 工作记录模块 *************************************/
/** 工作记录列表 */
#define LKWorkRecordList                @"hopson_manager/front/app/manager/interface/workRecordToApp/getByCreateTime"
/** 添加工作记录 */
#define LKAddWorkRecord                 @"hopson_manager/front/app/manager/interface/workRecordToApp/insert"
/** 修改工作记录 */
#define LKUpdateWorkRecord              @"hopson_manager/front/app/manager/interface/workRecordToApp/update"
/** 删除工作记录 */
#define LKDeleteWorkRecord              @"hopson_manager/front/app/manager/interface/workRecordToApp/delete"



/************************************ 登录模块 *************************************/
/** 登录 */
#define LKLogin                         @"hopson_manager/front/app/manager/interface/user/login"
/** 注册 */
#define LKRegister                      @"hopson_manager/front/app/manager/interface/user/register"
// 获取验证码
#define LKSendAuthCode                  @"hopson_manager/front/app/manager/interface/user/sendAuthCode"
/** 验证验证码 */
#define LKVerifyAuthCode                @"hopson_manager/front/app/manager/interface/user/verifyAuthCode"
/** 修改密码 */
#define LKChangePassword                @"hopson_manager/front/app/manager/interface/user/changePassword"
// 获取城市列表
#define LKCityList                      @"hopson_manager/front/app/manager/interface/user/cityList"
// 获取小区列表
#define LKBrunchList                    @"hopson_manager/front/app/manager/interface/user/brunchList"
// 查询角色信息
#define LKRoleList                      @"hopson_manager/front/app/manager/interface/user/roleList"
/** 提交审核信息 */
#define LKAddAudit                      @"hopson_manager/front/app/manager/interface/user/addAudit"
//评分
#define LKSubmitEnd                     @"hopson_manager/front/app/manager/interface/spotCheck/submitEnd"

/************************************ 首页模块 *************************************/
/** 首页用户最新信息 */
#define LKGetPersonNewMessage           @"hopson_im/front/app/im/message/getMessageNum"
/** 获取消息列表 */
#define LKGetPersonList                 @"hopson_im/front/app/im/message/getCharList"
/** 聊天详情信息 */
#define LKgetCharMessage                @"hopson_im/front/app/im/message/getCharMessage"
/** 发送消息 */
#define LKSendMessage                   @"hopson_im/front/app/im/message/sendMessage"
/** 获取历史消息 */
#define LKgetHistoryMessage             @"hopson_im/front/app/im/message/getHistoryMessage"


/************************************ 个人中心模块 *************************************/
/** 读取用户信息 */
#define LKReadPersonInfo                @"hopson_manager/admin/app/manager/interface/user/getUserInfo"
/** 更新用户信息 */
#define LKUpdateUserInfo                @"hopson_manager/front/app/manager/interface/user/updateUserInfo"




#endif /* LKNet_h */
