//
//  Uur_User_Interface.m
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import "Uur_User_Interface.h"
#import "NSObject+UUR_Utils.h"
#import "UIDevice+MacAddress.h"
#import "Uur_RequestTool.h"
#import "UurKeyChainDataManager.h"
#import "Uur_HttpRequestConstants.h"
#import "Uur_RequestTool.h"
#define uur_web_host @"UUR_WEB_HOST"
@implementation Uur_User_Interface


-(void)setUur_WebHost:(NSString *)host;
{
 
    [[NSUserDefaults  standardUserDefaults] setObject:host  forKey:uur_web_host];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)uur_login_by_account:(NSString *)mobile password:(NSString *)password channelId:(NSInteger )channelId systemVersion:(NSString *)systemVersion  success:(HTTPToolSuccess) success failure:(HTTPToolFailure) failure

{

    NSString * deviceType=[NSString getDeviceNo];
    NSString * phoneModel=[[UIDevice currentDevice] getDeviceVersion];
    NSUserDefaults *user=[NSUserDefaults  standardUserDefaults];
    NSString *umengDeviceToken=[user objectForKey:@"deviceToken"];
    if ([umengDeviceToken isEqualToString:@""]||umengDeviceToken==nil) {
        umengDeviceToken=@"";
    }
    if (mobile.length!=11) {
        Uur_mdoel *uur_model=[[Uur_mdoel alloc] init];
        uur_model.code=[NSNumber numberWithInteger:-1001];
        uur_model.message=@"phone number is error";
        success(uur_model);
    }
    NSDictionary *params=@{@"mobile":mobile,
                           @"password":password,
                           @"systemVersion":systemVersion,
                           @"deviceType":deviceType,
                           @"phoneModel":phoneModel,
                           @"channelId":@(channelId),
                           @"umengDeviceToken":umengDeviceToken};
    
    @try {
        [[Uur_RequestTool sharedHelper]sendAsyncRequest:uur_loing_by_account_HttpInterface verificationToken:NO params:params success:success failure:failure];
    } @catch (NSException *exception) {
        
        Uur_mdoel *uur_model=[[Uur_mdoel alloc] init];
        uur_model.code=[NSNumber numberWithInteger:-1001];
        uur_model.message=@"request exception";
        success(uur_model);
        NSLog(@"%@",exception);
    } @finally {
        
    }
  

    
    
}


 

@end
