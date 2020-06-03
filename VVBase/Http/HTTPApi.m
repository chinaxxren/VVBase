//
// Created by Jiangmingz on 2017/1/16.
// Copyright (c) 2017 SunYuanYang. All rights reserved.
//

#import "HTTPApi.h"

#import "ApiManager.h"
#import "ApiParam.h"
#import "RACSignal.h"

@interface HTTPApi ()

@property(nonatomic, strong) ApiManager *apiManager;

@end

@implementation HTTPApi


- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiManager = [ApiManager new];
    }

    return self;
}

+ (instancetype)createApi {
    static HTTPApi *apiManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        apiManager = [[self alloc] init];
    });

    return apiManager;
}

- (RACSignal *)getOutPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = AbsolutePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = HTTPResponseSerializer;
    params.path = path;
    params.requestMethod = Get;
    params.host = nil;

    return [self.apiManager requestApiParam:params];
}

@end