//
//  Uur_HttpRequestConstants.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Uur_HttpRequestConstants : NSObject


/**-----------------fronnt start-------------------**/
//注册接口
extern NSString * const  uur_register_account_HttpInterface;
//pt登录接口
extern NSString * const  uur_loing_by_account_HttpInterface;

extern NSString *const   uur_logout_HttpInterface;
//kj登录接口
extern NSString * const  uur_login_by_mobile_HttpInterface;
//获取短信验证码接口
extern NSString * const uur_get_mchkcode_HttpInterface;

//检测用户信息接口
extern NSString *const uur_check_mobile_name_HttpInterface;

extern NSString *const uur_check_token_status_HttpInterface;


/**-----------------fronnt end-------------------**/

//获取用户信息接口
extern NSString *const uur_user_info_HttpInterface;


//用户头像分组
extern NSString *const uur_get_avatars_HttpInterface;


//用户默认头像修改
extern NSString *const uur_change_default_avatar_HttpInterface;


//用户上传头像接口
extern NSString *const uur_upload_avatar_HttpInterface;


//用户银行卡列表获取
extern NSString *const   uur_get_support_banks_HttpInterface;


//用户银行卡绑定
extern NSString *const uur_binding_bank_card_HttpInterface;
//解除绑定接口
extern NSString *const  uur_unbound_bank_card_HttpInterface ;
//验证银行卡信息接口
extern NSString *const  uur_verify_bank_card_HttpInterface ;

//实名绑定接口
extern NSString  * const uur_verify_real_name_HttpInterface;



//开机图片获取接口
extern NSString *const uur_mock_app_pictures_HttpInterface;

@end
