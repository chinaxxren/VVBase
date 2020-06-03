//
// Created by Jiangmingz on 2017/1/16.
// Copyright (c) 2017 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@class ApiParam;
@class RACSignal;

@interface ApiManager : AFHTTPSessionManager

- (RACSignal *)requestApiParam:(ApiParam *)apiParam;

@end