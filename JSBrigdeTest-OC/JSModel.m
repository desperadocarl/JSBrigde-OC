//
//  JSModel.m
//  JSBrigdeTest-OC
//
//  Created by frank on 17/2/20.
//  Copyright © 2017年 TopHeavier. All rights reserved.
//

#import "JSModel.h"



@implementation JSModel



-(void)call:(NSString *)methodName :(NSDictionary *)params :(JSValue *)callBack{
    
    

    
    NSDictionary * data = [params objectForKey:@"data"];
    
    if ([methodName isEqualToString:@"showShareButton"]) {
        NSString * iconsStrUrl = [data objectForKey:@"icon"];
        if (iconsStrUrl) {
            NSURL * iconUrl = [NSURL URLWithString:iconsStrUrl];
            NSData * imageData = [NSData dataWithContentsOfURL:iconUrl];
            UIImage *image = [UIImage imageWithData:imageData scale:3];
            UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                               initWithImage:image
                                               style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(rightClick)];
            
            self.controller.navigationItem.rightBarButtonItem = rightBarButton;
            
        }
        else{
            UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                                  initWithTitle:@"分享"
                                                  style:UIBarButtonItemStylePlain
                                                  target:self
                                                  action:@selector(rightClick)];
            
            self.controller.navigationItem.rightBarButtonItem = rightBarButton;
        }
        
    }
    else if([methodName isEqualToString:@"setTitle"]){
        NSString * title = [data objectForKey:@"title"];
        self.controller.title = title;
    }
    else if([methodName isEqualToString:@"playVoice"]){
        NSString * resourceId = [data objectForKey:@"resource_id"];
        NSLog(@"resourceId%@",resourceId);
        
        NSString * url = [data objectForKey:@"url"];
        NSLog(@"plaVoiceUrl=%@",url);// 语音的链接
        
    }
    else if([methodName isEqualToString:@"openUrl"]){
        BOOL newWindow = [data objectForKey:@"new_window"];// 是在本窗口跳转还是新开一个窗口访问新网址
        NSString * url = [data objectForKey:@"url"];
        NSDictionary * params = [data objectForKey:@"params"];
        if (url) {
            NSLog(@"新的url将被打开%@",url);
            if (newWindow) {
                
            }
            else{
                NSLog(@"open url in current page");
            }
        }
    }
    else if([methodName isEqualToString:@"log"]){
        NSString * message = [data objectForKey:@"message"];
        NSLog(@"js需要的log%@",message);
    }
    else if ([methodName isEqualToString:@"prompt"]){
        NSArray * result = @[@{@"ok":@true,@"data":@"testCallBack"}];
        
        
        [callBack callWithArguments:result];
    }
        
    else{
        NSLog(@"none methodName incloud");
        
    }

    
}

-(void)rightClick{
    NSLog(@"rightClick");
}


@end
