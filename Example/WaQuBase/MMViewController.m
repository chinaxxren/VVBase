//
//  MMViewController.m
//  VVBase
//
//  Created by zhaojiangming on 02/15/2017.
//  Copyright (c) 2017 zhaojiangming. All rights reserved.
//

#import "MMViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

#import "AFHTTPSessionManager+RACSupport.h"
#import "ApiParam.h"
#import "ApiManager.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ApiParam *param = [ApiParam inApi];
    param.responseSerializer = JSONResponseSerializer;
    param.requestMethod = Get;
    param.pathType =  RelativePath;
    param.host = @"http://114.55.42.186/";
    param.realFullPath = @"http://114.55.42.186/hosts.json?ak=d2daaeecc813816a3209b6d66e9e46c2&appName=firebull&appVersion=10.0.0&applicationName=museum&isWifi=1&partner=0173&platform=ios&sid=9e7f6f42d87ffa555e6b8c0902e907a3&ts=1650958771&uid=5b51a84ba3149863b80387b0";
    ApiManager *manager =  [ApiManager manager];
    RACSignal *singal = [manager requestApiParam:param];
    [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
