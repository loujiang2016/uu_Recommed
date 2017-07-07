
//
//  UUr_Http_Block.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#ifndef UUr_Http_Block_h
#define UUr_Http_Block_h


//成功block
typedef void(^HTTPToolSuccess)(id josn);

//失败block
typedef void (^HTTPToolFailure)(NSError *error);

#endif /* UUr_Http_Block_h */
