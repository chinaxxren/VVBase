//
// Created by Jiangmingz on 2017/1/16.
// Copyright (c) 2017 SunYuanYang. All rights reserved.
//

#import "ApiManager.h"

#import "ApiParam.h"
#import "RACSignal.h"
#import "HttpCache.h"
#import "AFHTTPSessionManager+RACSupport.h"

@implementation ApiManager

- (void)prepare:(ApiParam *)apiParam {
    if (apiParam.requestSerializer == HTTPRequestSerializer) {
        self.requestSerializer = [[HttpCache share] httpRequestSerializer];
    } else {
        self.requestSerializer = [[HttpCache share] jsonRequestSerializer];
    }

    if (apiParam.responseSerializer == JSONResponseSerializer) {
        self.responseSerializer = [[HttpCache share] jsonResponseSerializer];
        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain",@"application/octet-stream"]];
    } else if (apiParam.responseSerializer == HTTPResponseSerializer) {
        self.responseSerializer = [[HttpCache share] httpResponseSerializer];
        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain",@"application/octet-stream"]];
    } else if (apiParam.responseSerializer == CompoundResponseSerializer) {
        self.responseSerializer = [[HttpCache share] compoundResponseSerializer];
    }

    self.securityPolicy = [[HttpCache share] securityPolicy];
    [self.requestSerializer setTimeoutInterval:apiParam.timeout];
}

- (RACSignal *)requestApiParam:(ApiParam *)apiParam {
    [self prepare:apiParam];

    if (apiParam.pathType == RelativePath) {
        return [[self int_requestApiParam:apiParam] setNameWithFormat:@"%@ -rac_Method: %@, parameters: %@", self.class, apiParam.path, [apiParam fieldParam]];
    } else {
        return [[self out_requestApiParam:apiParam] setNameWithFormat:@"%@ -rac_Method: %@, parameters: %@", self.class, apiParam.path, [apiParam fieldParam]];
    }
}

@end
