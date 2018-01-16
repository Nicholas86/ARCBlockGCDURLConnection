//
//  ASyncURLConnection.m
//  ARCBlockGCDURLConnection
//
//  Created by a on 2018/1/16.
//  Copyright © 2018年 a. All rights reserved.
//

#import "ASyncURLConnection.h"

@implementation ASyncURLConnection

//初始化
- (id)initWithRequest:(NSString *)requestUrl completeBlock:(CompleteBlock_t)completeBlock errorBlock:(ErrorBlock_t)errorBlcok
{
    NSURL *url = [NSURL  URLWithString:requestUrl];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    self = [super  initWithRequest:request delegate:self startImmediately:NO];
    if (self) {
        data_ = [[NSMutableData  alloc] init];
        /*
         为了在之后的代码安全地使用
         传递到此方法中的Block,
         调用copy实例方法
         确保Block
         被分配到堆上
         */
        completeBlock_t = [completeBlock copy];
        errorBlock_t = [errorBlcok copy];
        [self start];
        /*
         生成的NSMutableData类对象和
         copy的Block由附有__strong修饰符的成员变量
         
         强引用,处于被持有的状态。
         
         因此如果该对象被废弃,
         附有__strong修饰符成员变量的强引用也随之失效,
         NSMutableData类对象和
         Block自动地释放。
         
         由此dealloc实例方法
         不用显示实现
         */
        
    }return self;
}

//便利构造器
+ (id)request:(NSString *)requestUrl completeBlock:(CompleteBlock_t)completeBlock errorBlock:(ErrorBlock_t)errorBlcok
{
    return [[self alloc] initWithRequest:requestUrl completeBlock:completeBlock errorBlock:errorBlcok];
}


#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [data_  setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [data_  appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /*
     下载成功时调用用于回调的Block
     */
    
    completeBlock_t(data_);
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    /*
     下载错误时,用于回调的Block
     */
    errorBlock_t(error);
}
@end



