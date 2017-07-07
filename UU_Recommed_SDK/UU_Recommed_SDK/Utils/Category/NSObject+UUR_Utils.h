//
//  NSObject+UUR_Utils.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (UUR_Utils)

- (NSString*) trim;

- (NSString *) md5String;

+ (NSString *) appVersion;

- (CGSize) sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)getIPAddress:(BOOL)preferIPv4;

- (NSDictionary *)getIPAddresses;

+(NSString *)getDeviceNo;

@end
