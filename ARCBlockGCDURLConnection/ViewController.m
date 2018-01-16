//
//  ViewController.m
//  ARCBlockGCDURLConnection
//
//  Created by a on 2018/1/16.
//  Copyright © 2018年 a. All rights reserved.
//

#import "ViewController.h"
#import "ASyncURLConnection.h"

@interface ViewController ()
{
    NSString *url;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    url = @"https://cdn.staging.baifotong.com/media/incenses/orders/201801/20180115150806_incense_20180115_070806_3333.png";
    [self  loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//请求数据
- (void)loadData
{
    
    /*
    在主线程中,从指定的URL开始异步网络下载
    */
    [ASyncURLConnection  request:url completeBlock:^(NSData *data) {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            /*
             在GCD中对下载的数据进行解析
             不妨碍主线程,可长时间处理
             */
            UIImage *image = [UIImage  imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /*
                 在Main Dispatch Queue中使用解析结果。
                 对用户界面进行反应处理
                 */
                self.backImageView.image  = image;
            });
        });
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"发生错误:%@", error);
    }];
}

@end





