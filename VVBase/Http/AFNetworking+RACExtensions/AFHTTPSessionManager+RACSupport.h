//
//  AFHTTPSessionManager+In.h
//  Reactive AFNetworking Example
//
//  Created by Robert Widmann on 5/20/14.
//  Copyright (c) 2014 CodaFi. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@class RACSignal;
@protocol ApiParamInterFace;

extern NSString *const RACAFNResponseObjectErrorKey;

@interface AFHTTPSessionManager (RACSupport)

- (RACSignal *)out_requestApiParam:(id <ApiParamInterFace>)apiParamInterFace;

- (RACSignal *)int_requestApiParam:(id <ApiParamInterFace>)apiParamInterFace;

@end
