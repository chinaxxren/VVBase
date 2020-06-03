//
// Created by 赵江明 on 2016/12/23.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFSecurityPolicy;
@class AFHTTPRequestSerializer;
@class AFHTTPRequestSerializer;
@class AFHTTPResponseSerializer;
@class AFJSONResponseSerializer;
@class AFCompoundResponseSerializer;

@interface HttpCache : NSObject

+ (instancetype)share;

- (AFSecurityPolicy *)securityPolicy;

#pragma mark Http Request

- (AFHTTPRequestSerializer *)httpRequestSerializer;

- (AFHTTPRequestSerializer *)jsonRequestSerializer;

#pragma mark Http Response

- (AFHTTPResponseSerializer *)httpResponseSerializer;

- (AFJSONResponseSerializer *)jsonResponseSerializer;

- (AFCompoundResponseSerializer *)compoundResponseSerializer;

@end
