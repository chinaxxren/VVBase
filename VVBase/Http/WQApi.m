//
// Created by Jiangmingz on 2016/12/22.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import "WQApi.h"

#import "ApiParam.h"
#import "RACSignal.h"
#import "ApiManager.h"

@interface WQApi ()

@property(nonatomic, strong) ApiManager *apiManager;

@end

@implementation WQApi

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiManager = [ApiManager new];
    }

    return self;
}

+ (instancetype)createApi {
    static WQApi *apiManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        apiManager = [[self alloc] init];
    });

    return apiManager;
}

- (RACSignal *)getUpdateInPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Get;
    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)postInPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Post;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)getInPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Get;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)getPicstatPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Get;


    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)postStaticPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;
    params.path = path;
    params.requestMethod = Post;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)getStaticPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Get;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)postLogPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Post;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)getFeedbackPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Get;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)postFeedbackPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;

    params.path = path;
    params.requestMethod = Post;

    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)getSnapPath:(NSString *)path params:(ApiParam *)params{
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;
    
    params.path = path;
    params.requestMethod = Get;
    
    return [self.apiManager requestApiParam:params];
    
}

- (RACSignal *)postSnapPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;
    
    params.path = path;
    params.requestMethod = Post;
    
    return [self.apiManager requestApiParam:params];
}

- (RACSignal *)getPicstatPathSnap:(NSString *)path params:(ApiParam *)params {
    params.pathType = RelativePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = JSONResponseSerializer;
    
    params.path = path;
    params.requestMethod = Get;
    
    return [self.apiManager requestApiParam:params];
}



@end
