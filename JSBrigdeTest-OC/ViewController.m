//
//  ViewController.m
//  JSBrigdeTest-OC
//
//  Created by frank on 17/2/20.
//  Copyright © 2017年 TopHeavier. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSModel.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) JSContext * jsContext;
@property (nonatomic, strong) NSString * htmlCont;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                          ofType:@"html"];
    self.htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:self.htmlCont baseURL:baseURL];
  
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //oc打印js中的异常
    [self.jsContext setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"oc catches the exception: %@", value);
    }];
    
    JSModel * model = [[JSModel alloc]init];
    model.controller = self;
    model.JSContext = self.jsContext;
    NSString * key = @"DDJSBridge";
    
    [self.jsContext setObject:model forKeyedSubscript:key];
    [self.jsContext evaluateScript:self.htmlCont];
    
   
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
