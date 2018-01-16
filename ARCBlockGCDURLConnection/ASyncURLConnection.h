//
//  ASyncURLConnection.h
//  ARCBlockGCDURLConnection
//
//  Created by a on 2018/1/16.
//  Copyright © 2018年 a. All rights reserved.
//

#import <Foundation/Foundation.h>

//成功回调
typedef void(^CompleteBlock_t)(NSData *data);

//失败回调
typedef void(^ErrorBlock_t)(NSError *error);

@interface ASyncURLConnection : NSURLConnection<NSURLConnectionDataDelegate>
{
    /*
     由于ARC有效,所以以下的
     没有显示附加所有权修饰符的变量
     全部【默认】为附有__strong修饰符的变量。
     */
    
    NSMutableData *data_;
    CompleteBlock_t  completeBlock_t;
    ErrorBlock_t errorBlock_t;
}


/*
 为提高源代码的可读性
 使用typedef的Block类型变量作为参数
 */
//初始化
- (id)initWithRequest:(NSString *)requestUrl
        completeBlock:(CompleteBlock_t )completeBlock
           errorBlock:(ErrorBlock_t )errorBlcok;


//便利构造器
+ (id)request:(NSString *)requestUrl
completeBlock:(CompleteBlock_t )completeBlock
   errorBlock:(ErrorBlock_t )errorBlcok;


@end






