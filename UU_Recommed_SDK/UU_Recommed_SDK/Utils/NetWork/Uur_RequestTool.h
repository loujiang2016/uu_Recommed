//
//  Uur_RequestTool.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Uur_mdoel.h"
#import "UUr_Http_Block.h"


@interface Uur_RequestTool : NSObject


+(instancetype)sharedHelper;


-(void)sendAsyncRequest:(NSString *)url  verificationToken:(BOOL )verificationToken  params:(NSDictionary *)params
               success :(HTTPToolSuccess) success  failure:(HTTPToolFailure) failure;
@end
