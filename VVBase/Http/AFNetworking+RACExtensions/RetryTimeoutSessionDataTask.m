//
// Created by 赵江明 on 15/11/27.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//


#import "RetryTimeoutSessionDataTask.h"

#import <ReactiveObjC/ReactiveObjC.h>

#import "UALogger.h"

static dispatch_queue_t retryQueue;

@interface RetryTimeoutSessionDataTask ()

@property(nonatomic, readwrite, assign) int64_t retryTime;

/*
 *  Stores how many retries will be done
 */
@property(nonatomic, readwrite, assign) NSInteger numberOfRetries;

/*
 *  Stores how many retries are left to do (if failed)
 */
@property(nonatomic, assign) NSInteger retriesLeft;

//
// Private properties
//
@property(nonatomic, copy) NSURLRequest *request;

@property(nonatomic, copy) void (^completionHandler)(NSURLResponse *, id, NSError *);

@property(nonatomic, strong) NSURLSessionDataTask *currentTask;

@end

@implementation RetryTimeoutSessionDataTask

- (void)dealloc {
    UALog(@"%s", __func__);
    self.taskCreator = nil;
}

/**
 延时多少秒retryTime
 重复多少次numberOfRetries
 **/
- (instancetype)initWithRequest:(NSURLRequest *)request
                numberOfRetries:(NSInteger)numberOfRetries
                      retryTime:(int64_t)retryTime
              completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler {
    self = [super init];
    if (self) {
        if (!retryQueue) {
            retryQueue = dispatch_queue_create("com.waqu.retry.timeout", DISPATCH_QUEUE_SERIAL);
        }

        self.request = request;
        self.retryTime = retryTime;
        self.numberOfRetries = numberOfRetries;
        self.retriesLeft = numberOfRetries - 1;
        self.completionHandler = completionHandler;
    }

    return self;
}

- (void)resume {
    if (self.taskCreator) {
        self.currentTask = self.taskCreator(self.request, [self retryBlock]);
    }

    [self.currentTask resume];
}

- (void)cancel {
    [self.currentTask cancel];
}

- (RACURLSessionRetryDataTaskBlock)retryBlock {

    @weakify(self);
    RACURLSessionRetryDataTaskBlock retryBlock = ^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);

        if (error) {
            BOOL retryTest = YES;

            if (self.testBlock) {
                retryTest = self.testBlock(response, responseObject, error);
            }

            // This is the retry logic
            if ((self.retriesLeft > 0) && retryTest) {

                self.retriesLeft--;

                [self.currentTask cancel];
                self.currentTask = nil;

                dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, self.retryTime * NSEC_PER_SEC);
                dispatch_after(delay, retryQueue, ^(void) {
                    @strongify(self);

                    [self resume];
                });
            } else if (self.completionHandler) {
                self.completionHandler(response, responseObject, error);
            }
        } else if (self.completionHandler) {
            self.completionHandler(response, responseObject, error);
        }
    };

    return retryBlock;
}

@end
