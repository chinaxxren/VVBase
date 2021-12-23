//
//  AFHTTPSessionManager+In.m
//  Reactive AFNetworking Example
//
//  Created by Robert Widmann on 5/20/14.
//  Copyright (c) 2014 CodaFi. All rights reserved.
//

#import "AFHTTPSessionManager+RACSupport.h"

#import <ReactiveObjC/ReactiveObjC.h>

#import "RetryTimeoutSessionDataTask.h"
#import "NetConstans.h"
#import "ApiParamInterFace.h"

NSString *const RACAFNResponseObjectErrorKey = @"responseObject";

static NSString *TimeoutText = @"network_timeout";

@implementation AFHTTPSessionManager (RACSupport)

- (RACSignal *)int_requestApiParam:(id <ApiParamInterFace>)apiParamInterFace {
    AFHTTPRequestSerializer <AFURLRequestSerialization> *serializer = self.requestSerializer;
    serializer.timeoutInterval = apiParamInterFace.timeout;

    @weakify(self);
    return [RACSignal createSignal:^(id <RACSubscriber> subscriber) {
        NSMutableURLRequest *request = [serializer requestWithMethod:[apiParamInterFace method]
                                                           URLString:[apiParamInterFace realFullPath]
                                                          parameters:[apiParamInterFace fieldParam]
                                                               error:nil];

        [request setAllHTTPHeaderFields:[apiParamInterFace headerParam]];

        RetryTimeoutSessionDataTask *task = [[RetryTimeoutSessionDataTask alloc] initWithRequest:request
                                                                                 numberOfRetries:apiParamInterFace.retries
                                                                                       retryTime:apiParamInterFace.retrytime
                                                                               completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

                                                                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                                   NSDictionary *responseDict = (NSDictionary *) responseObject;

                                                                                    if(!responseObject && !error) {
                                                                                        [subscriber sendNext:responseObject];
                                                                                        [subscriber sendCompleted];
                                                                                    } else if (!httpResponse || !responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) {
                                                                                       NSString *locaTimeoutText = NSLocalizedString(TimeoutText, nil);
                                                                                       if ([locaTimeoutText isEqualToString:TimeoutText]) {
                                                                                           locaTimeoutText = @"网络请求超时!";
                                                                                       }
                                                                                       NSError *myError = [NSError errorWithDomain:[ERROR_DOMAIM copy]
                                                                                                                              code:1000
                                                                                                                          userInfo:@{ERROR_MESSAGE: locaTimeoutText}];
                                                                                       [subscriber sendError:myError];
                                                                                   } else if (responseDict[@"success"] && ![responseDict[@"success"] boolValue]) {
                                                                                       NSString *message;
                                                                                       if (responseDict[@"msg"]) {
                                                                                           message = responseDict[@"msg"];
                                                                                       } else if (responseDict[@"message"]) {
                                                                                           message = responseDict[@"message"];
                                                                                       } else {
                                                                                           message = @"";
                                                                                       }

                                                                                       NSError *myError = [NSError errorWithDomain:[ERROR_DOMAIM copy]
                                                                                                                              code:0
                                                                                                                          userInfo:@{ERROR_MESSAGE: message, ERROR_OBJECT: responseDict}];
                                                                                       [subscriber sendError:myError];
                                                                                   } else if (httpResponse.statusCode == 403 || [responseDict[@"status"] integerValue] == 403) {
                                                                                       [subscriber sendError:error];
                                                                                       [[NSNotificationCenter defaultCenter] postNotificationName:ERROR_403 object:nil];
                                                                                   } else if (httpResponse.statusCode >= 400 || error) {
                                                                                       NSError *myError = [NSError errorWithDomain:error.domain
                                                                                                                              code:httpResponse.statusCode
                                                                                                                          userInfo:error.userInfo];
                                                                                       [subscriber sendError:myError];
                                                                                   } else {
                                                                                       [subscriber sendNext:responseObject];
                                                                                       [subscriber sendCompleted];
                                                                                   }
                                                                               }];

        task.taskCreator = ^NSURLSessionDataTask *(NSURLRequest *req, RACURLSessionRetryDataTaskBlock retryBlock) {
            @strongify(self);
            return [self dataTaskWithRequest:req
                              uploadProgress:NULL
                            downloadProgress:NULL
                           completionHandler:retryBlock];
        };

        [task resume];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }
    ];
}

- (RACSignal *)out_requestApiParam:(id <ApiParamInterFace>)apiParamInterFace {
    AFHTTPRequestSerializer <AFURLRequestSerialization> *serializer = self.requestSerializer;
    serializer.timeoutInterval = apiParamInterFace.timeout;

    @weakify(self);
    return [RACSignal createSignal:^(id <RACSubscriber> subscriber) {
        NSMutableURLRequest *request = [serializer requestWithMethod:[apiParamInterFace method]
                                                           URLString:[apiParamInterFace realFullPath]
                                                          parameters:[apiParamInterFace fieldParam]
                                                               error:nil];
        if ([apiParamInterFace hasHeaderParam]) {
            [request setAllHTTPHeaderFields:[apiParamInterFace headerParam]];
        }

        @strongify(self);
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request
                                                uploadProgress:NULL
                                              downloadProgress:NULL
                                             completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                 if (error) {
                                                     NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                                                     if (responseObject) {
                                                         userInfo[RACAFNResponseObjectErrorKey] = responseObject;
                                                     }
                                                     NSError *errorWithRes = [NSError errorWithDomain:error.domain code:error.code userInfo:[userInfo copy]];
                                                     [subscriber sendError:errorWithRes];
                                                 } else {
                                                     [subscriber sendNext:responseObject];
                                                     [subscriber sendCompleted];
                                                 }
                                             }];

        [task resume];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
