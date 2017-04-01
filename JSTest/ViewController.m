//
//  ViewController.m
//  JSTest
//
//  Created by Tiya on 2017/3/14.
//  Copyright © 2017年 Tiya. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface ViewController () <UIWebViewDelegate>{
    UIWebView *myWebView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testJS];
}

- (void)testJS {
    //初始化webview
    myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 22, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-22)];
    myWebView.delegate = self;
    //添加webview到当前viewcontroller的view上
    [self.view addSubview:myWebView];
    
    //网址
    NSString *httpStr=@"https://www.baidu.com";
    NSURL *httpUrl=[NSURL URLWithString:httpStr];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:httpUrl];
    [myWebView loadRequest:httpRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *alertJS = @"alert('test js OC')"; //准备执行的js代码
    [context evaluateScript:alertJS];//通过oc方法调用js的alert
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
}

@end
