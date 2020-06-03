//
// Created by Jiangmingz on 2017/1/16.
// Copyright (c) 2017 SunYuanYang. All rights reserved.
//

#import "CompoundApi.h"

#import "ApiParam.h"
#import "RACSignal.h"
#import "ApiManager.h"

@interface CompoundApi ()

@property(nonatomic, strong) ApiManager *apiManager;

@end

@implementation CompoundApi

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiManager = [ApiManager new];
    }

    return self;
}

+ (instancetype)createApi {
    static CompoundApi *apiManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        apiManager = [[self alloc] init];
    });

    return apiManager;
}

- (RACSignal *)getImgPath:(NSString *)path params:(ApiParam *)params {
    params.pathType = AbsolutePath;
    params.requestSerializer = HTTPRequestSerializer;
    params.responseSerializer = CompoundResponseSerializer;
    params.path = path;
    params.requestMethod = Get;
    
    return [self.apiManager requestApiParam:params];
}

@end
