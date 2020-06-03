//
// Created by 赵江明 on 15/11/27.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//


#pragma mark - Usage blocks
@import UIKit;

typedef void (^RACURLSessionRetryDataTaskBlock)(NSURLResponse *response, id responseObject, NSError *error);

typedef BOOL (^RACURLSessionRetryTestBlock)(NSURLResponse *response, id responseObject, NSError *error);

/*!
 *  Block that allocates a new task, is used by AFHTTPSessionManager
 *
 *  @param request    provides request
 *  @param retryBlock retry block to be executed when data task fails
 *
 *  @return new NSURLSessionDataTask
 */
typedef NSURLSessionDataTask *(^RACURLSessionDataTaskCreator)(NSURLRequest *request, RACURLSessionRetryDataTaskBlock retryBlock);

#pragma mark - RACURLSessionRetryDataTask

/*!
 *  Wrapper that creates and executes multiple data tasks one after one
 */
@interface RetryTimeoutSessionDataTask : NSObject

@property(nonatomic, readonly) int64_t retryTime;

@property(nonatomic, readonly) NSInteger numberOfRetries;

/*!
 *  Must be set so each retry has gets allocated a new task
 */
@property(nonatomic, copy) RACURLSessionDataTaskCreator taskCreator;

/*!
 *  Optional, if set, it is called on error and must return YES,
 *  if retry criteria is matched, this enables you to stop retries under special conditions, such as
 *  4xx errors.
 */
@property(nonatomic, copy) RACURLSessionRetryTestBlock testBlock;

- (instancetype)initWithRequest:(NSURLRequest *)request
                numberOfRetries:(NSInteger)numberOfRetries
                      retryTime:(int64_t)retryTime
              completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler;

- (void)resume;

- (void)cancel;

@end
