//
//  Uur_RequestTool.m
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import "Uur_RequestTool.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "GTMBase64.h"
#import "Uur_CommonConstans.h"
#import "LEncrypt.h"
#import "Uur_UserManager.h"
#import "Uur_User.h"
#import <YYModel.h>
#import "UurKeyChain.h"
#import "UurKeyChainDataManager.h"
#define uur_web_host @"UUR_WEB_HOST"
#define UUR_USER_OPEN_UDID @"UUR_USER_OPEN_UDID"


#ifdef Project_TestInLine
#define NEED_ENCRYPTED 0
#else
#define NEED_ENCRYPTED 0
#endif



@implementation Uur_RequestTool

+(instancetype)sharedHelper
{
    static Uur_RequestTool *request=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!request) {
            request=[[Uur_RequestTool alloc] init];
            [request setUUID];
        }
    });
    return  request;
}




-(void)sendAsyncRequest:(NSString *)url  verificationToken:(BOOL )verificationToken  params:(NSDictionary *)params
               success :(HTTPToolSuccess) success  failure:(HTTPToolFailure) failure{

 
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    NSString *WebHost= [defaults objectForKey:uur_web_host];
    if (WebHost==nil||[WebHost isEqualToString:@""]) {
    
        Uur_mdoel *model=[[Uur_mdoel alloc] init];
        model.code=[NSNumber numberWithInt:-1000];
        model.message=@"未设置WebHost地址";
        success(model);
        return;
    }
    
    //提交地址
    NSString * posturl=[NSString stringWithFormat:@"%@%@",WebHost,url];
    
    
    //版本号跟服务器定义
    NSString *version=[self appVersion];
    
    //请求时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%lld",(long long)([[NSDate date] timeIntervalSince1970]*1000)];
    
    NSRange range={0,12};
    
    //Md5后参数规则
    NSString *nonce = [[[self md5String: timestamp] lowercaseString] substringWithRange:range];;
    
    //唯一设备标示
    NSString *deviceNo=[self getDeviceNo];

    //要签证签名的参数
    NSString *presignature = [NSString stringWithFormat:@"%@_%@_%@_%@",url,version,timestamp,nonce];

    
    NSLog(@"webHost:%@",WebHost);
    NSLog(@"url:%@",url);
    NSLog(@"version:%@",version);
    NSLog(@"timestamp:%@",timestamp);
    NSLog(@"nonce:%@",nonce);
    NSLog(@"presignature:%@",presignature);
    
    
    
    NSString *key=nil;
    if (verificationToken) {
    

        if ([[params allKeys] containsObject:@"accessToken"]) {
           
           
           
           key=[self keyForUrl:url token:params[@"accessToken"]];
           
        }
        else{
        
           Uur_mdoel *model=[[Uur_mdoel alloc] init];
           model.code=[NSNumber numberWithInt:-1001];
           model.message=@"未设置token";
           success(model);
           return;

           
        }
       
    }
    else{
    
        key=[self keyForUrl:url token:nil];
        
    }

    NSString *signature=[LEncrypt doEncryptHex:presignature withKey:key];
   
   
   Uur_User *user=[[Uur_UserManager sharedManager] currentUser];
   
   if (!params&&user) {
      
      params = @{
                 @"accessToken":user.accessToken,
                 @"version"   : version,
                 @"deviceNo"  : deviceNo,
                 @"timestamp" : timestamp,
                 @"nonce"     : nonce,
                 @"signature" : signature  ,
                 @"deviceTypeStr" : @"IOS",
                 @"deviceType":@(1)
                 };
  
   
   }
   else{
   
     // 公共头存在的考量参数
      NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:params];
      [dict setObject:version forKey:@"version"];
      [dict setObject:deviceNo forKey:@"deviceNo"];
      [dict setObject:timestamp forKey:@"timestamp"];
      [dict setObject:nonce forKey:@"nonce"];
      [dict setObject:@(1) forKey:@"deviceType"];
      [dict setObject:signature forKey:@"signature"];
      params=nil;
      params=dict;
      
   }
   
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:params];
   
   if (!NEED_ENCRYPTED) {
      [requestParams setObject:@"0" forKey:@"noHeaderCheck"];
      [requestParams setObject:@"0" forKey:@"noEncrypted"];
   }
   
   AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
   
   manager.requestSerializer.timeoutInterval=5000;

   manager.requestSerializer=[AFHTTPRequestSerializer serializer
                              ];
   
   manager.responseSerializer=[AFJSONResponseSerializer serializer];
   
   manager.responseSerializer.acceptableContentTypes=[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
   
   
   [manager GET:posturl parameters:requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      if (responseObject) {
         
         Uur_mdoel * model=[Uur_mdoel yy_modelWithDictionary:(NSDictionary *)responseObject];
         
   
         //重复请求
         if([model.code integerValue]==96) return ;
         
         success(model);
      }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
      failure(error);
   }];
   
}


-(NSString *)keyForUrl:(NSString *)url token:(NSString *)token
{
    NSString *key ;
    if ([self string:url containsString:@"front"]) {
        NSString *preKey=[self md5String:uur_DesClientKey];
        NSLog(@"prekey:%@",preKey);
        key=[[preKey substringWithRange:NSMakeRange(0, 24)] lowercaseString];
        NSLog(@"key :%@",key);
    }
    else
    {
        NSString *pre=token;
        NSString *prekey=[self md5String:pre];
        key=[[prekey substringWithRange:NSMakeRange(0, 24)] lowercaseString];
    }
    
    return key;
}
-(BOOL)string:(NSString *)basic containsString:(NSString *)other
{
    NSRange range=[basic rangeOfString:other];    
    return range.length;

}

-(NSString *) appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *) md5String:(NSString *)escStr
{
    const char *cStr = [escStr UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the
    
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
    
}

-(NSString *)getDeviceNo
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *deviceNO=[user  objectForKey:UUR_USER_OPEN_UDID];
    return  deviceNO;
}


-(void)setUUID
{
   NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
   NSString *uuid=[user  objectForKey:UUR_USER_OPEN_UDID];
   if (uuid==nil||[uuid isEqualToString:@""]) {
      uuid=[UurKeyChainDataManager  readUUID];
      if (uuid==nil||[uuid isEqualToString:@""]) {
         uuid = [[NSUUID UUID] UUIDString];
         [UurKeyChainDataManager  saveUUID:uuid];
         [user setObject:uuid forKey:UUR_USER_OPEN_UDID];
      }
      else
      {
         [user setObject:uuid forKey:UUR_USER_OPEN_UDID];
      }
   }
}

@end
