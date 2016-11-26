//
//  ZTOAuthViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/3/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "ZTAccount.h"
#import "ZTAccountTool.h"
#import "ZTRootTool.h"
#import "ZTAccountTool.h"


@interface ZTOAuthViewController ()<UIWebViewDelegate>

@end

@implementation ZTOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //显示登录网页->UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    //一个完整的URL:基本URL + 参数
    //拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",ZTAuthorizeBaseUrl,ZTClient_id,ZTRedirect_uri];
    
    //创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //加载请求
    [webView loadRequest:request];
    
    webView.delegate = self;
}

#pragma mark - UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView{

    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    ZTLog(@"error==>>%@",error);
    
    [MBProgressHUD hideHUD];
}

//拦截webView请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    //获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        ZTLog(@"%@",code);
        
        [self accessTokenWithCode:code];
        
        return NO;

    }
    
    return YES;
    
}

- (void)accessTokenWithCode:(NSString *)code{
    
    [ZTAccountTool accountWithCode:code success:^{
        
        // 进入主页或者新特性,选择窗口的根控制器
        [ZTRootTool chooseRootViewController:ZTKeyWindow];
        
    } failure:^(NSError *error) {
        
        //请求失败
        ZTLog(@"请求失败");
        
    }];

}

@end


