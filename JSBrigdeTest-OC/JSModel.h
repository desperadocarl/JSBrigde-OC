//
//  JSModel.h
//  JSBrigdeTest-OC
//
//  Created by frank on 17/2/20.
//  Copyright © 2017年 TopHeavier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol JSDelegate <JSExport>

@required

-(void)call :(NSString *)methodName :(NSDictionary *)params :(JSValue *)callBack;

@end


@interface JSModel : NSObject<JSDelegate>

@property(weak,nonatomic) UIViewController * controller;
@property(weak,nonatomic) JSContext * JSContext;

@end
