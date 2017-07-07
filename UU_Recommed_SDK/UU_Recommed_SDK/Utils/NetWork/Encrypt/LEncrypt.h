//
//  LEncrypt.h
//  Recommend
//
//  Created by Jiang Lou on 2017/6/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEncrypt : NSObject

/**字符串加密 */
+(NSString *)doEncryptStr:(NSString *)originalStr withKey:(NSString *)key;
/**字符串解密 */
+(NSString*)doDecEncryptStr:(NSString *)encryptStr withKey:(NSString *)key;
/**十六进制加密 */
+(NSString *)doEncryptHex:(NSString *)originalStr withKey:(NSString *)key;
/**十六进制解密 */
+(NSString*)doDecEncryptHex:(NSString *)encryptStr withKey:(NSString *)key;



@end
