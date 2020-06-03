//
// Created by Jiangmingz on 2016/12/22.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ApiParam;
@class RACSignal;

@interface WQApi : NSObject

+ (instancetype)createApi;

- (RACSignal *)postInPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getInPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getPicstatPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getUpdateInPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)postStaticPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getStaticPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)postLogPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getFeedbackPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)postFeedbackPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getSnapPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)postSnapPath:(NSString *)path params:(ApiParam *)params;

- (RACSignal *)getPicstatPathSnap:(NSString *)path params:(ApiParam *)param;

@end
