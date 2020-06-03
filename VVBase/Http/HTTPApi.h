//
// Created by Jiangmingz on 2017/1/16.
// Copyright (c) 2017 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ApiParam;
@class RACSignal;

@interface HTTPApi : NSObject

+ (instancetype)createApi;

- (RACSignal *)getOutPath:(NSString *)path params:(ApiParam *)params;

@end