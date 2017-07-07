//
//  Uur_User_Interface.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Uur_User.h"
#import "UUr_Http_Block.h"




@interface Uur_User_Interface : NSObject


-(void)setUur_WebHost:(NSString *)host;



/**
 用户登录接口 账户密码登录
 @parmas  mobile 手机号
 @parmas  password  密码
 @parmas  channelId 渠道来源
 */
+(void)uur_login_by_account:(NSString *)mobile password:(NSString *)password channelId:(NSInteger )channelId systemVersion:(NSString *)systemVersion  success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure;;


/**
 用户登录接口 账户  验证码快捷登录
 @parmas mobile    手机号
 @parmas  chkcode  验证码
 @parmas  chanelId 来源渠道
 */
//
//+(void)uur_login_by_moblie:(NSString *)mobile  chkCode:(NSString *)chkCode
//                 channelId:(NSInteger )channelId  systemVersion:(NSString *)systemVersion  success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure;;

/**
 短信验证码获取
 *
 */
//+(void)uur_get_mchkcode:(NSString *)mobile  chkCodeType:(NSInteger)chkCodeType testEnvSend:(NSString *)testEnvSend success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure;

/*
 * 获取用户登录信息
 * @parmas
 */
//+(void)uur_user_info:(NSString *)token  success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure;;


/*
 *检测token信息
 */
//+(void)uur_check_token_status:(NSString *)token  success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure;


/*
 *用户退出
 */
//+(void)uur_logout:(NSString *)token success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure;


@end
