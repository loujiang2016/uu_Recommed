//
//  Uur_User.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,UUr_UserSex) {
    LUserSexMan = 1,
    LUserSexWoMan = 2,
};

typedef NS_ENUM(NSUInteger,UUr_LoginStatus)
{
    Uur_UserLoginStatus=1,
    Uur_UserLoginoutStatus=0
};

@interface Uur_User : NSObject



//用户id
@property(nonatomic,assign)NSInteger  userId;

//登录账户
@property(nonatomic,copy) NSString * loginAccount;

//密码
@property(nonatomic,copy) NSString *  loginPwd;

//昵称
@property(nonatomic,copy) NSString *  nickName;

//登录类型
@property(nonatomic,assign) NSInteger   accessType;

//锁定状态
@property(nonatomic,assign) BOOL   accountStatus;

//是否是第一次登录
@property(nonatomic,assign) BOOL  firstLogin;

//token
@property(nonatomic,copy) NSString * accessToken;

//更新refreshToken
@property(nonatomic,copy)  NSString * refreshToken;

//token有效时间
@property(nonatomic,copy)  NSString * accessTokenTime;

//刷新token时间
@property(nonatomic,copy) NSString * refreshTokenTime;

//真实姓名
@property(nonatomic,copy) NSString *realName;

//cardNo  身份证号
@property(nonatomic,copy) NSString *cardNo;

//生日
@property(nonatomic,strong) NSString *birthday;

//性别
@property(nonatomic,assign) UUr_UserSex gender;

//卡类型
@property(nonatomic,assign) NSInteger cardType;

//用户头像
@property(nonatomic,copy) NSString *userHeader;

@property(nonatomic,assign) UUr_LoginStatus loginstatus;

//是否实名
@property(nonatomic,assign)  NSInteger verifyStatus;@end
