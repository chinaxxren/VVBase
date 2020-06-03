//
// Created by 赵江明 on 2016/12/23.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import "HttpCache.h"

#import <AFNetworking/AFSecurityPolicy.h>
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFURLResponseSerialization.h>

@implementation HttpCache {
    AFSecurityPolicy *_securityPolicy;
}

+ (instancetype)share {
    static HttpCache *httpCache;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        httpCache = [[HttpCache alloc] init];
    });

    return httpCache;
}

- (AFSecurityPolicy *)securityPolicy {
    if (!_securityPolicy) {
        _securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _securityPolicy.allowInvalidCertificates = YES;
        _securityPolicy.validatesDomainName = NO;
    }

    return _securityPolicy;
}

#pragma mark Http Request

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    AFHTTPRequestSerializer *httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    return httpRequestSerializer;
}

- (AFJSONRequestSerializer *)jsonRequestSerializer {
    AFJSONRequestSerializer *jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    return jsonRequestSerializer;
}

#pragma mark Http Response

- (AFHTTPResponseSerializer *)httpResponseSerializer {
    AFHTTPResponseSerializer *httpResponseSerializer = [AFHTTPResponseSerializer serializer];
    return httpResponseSerializer;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    jsonResponseSerializer.removesKeysWithNullValues = YES;
    return jsonResponseSerializer;
}

- (AFCompoundResponseSerializer *)compoundResponseSerializer {
    AFCompoundResponseSerializer *compoundResponseSerializer = [AFCompoundResponseSerializer serializer];
    return compoundResponseSerializer;
}


@end