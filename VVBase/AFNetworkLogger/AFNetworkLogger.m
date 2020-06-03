// AFNetworkLogger.h
//
// Copyright (c) 2013 AFNetworking (http://afnetworking.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFNetworkLogger.h"
#import "AFURLSessionManager.h"
#import "UALogger.h"
#import <objc/runtime.h>

static NSURLRequest *AFNetworkRequestFromNotification(NSNotification *notification) {
    NSURLRequest *request = [[notification object] originalRequest];
    return request;
}

static NSError *AFNetworkErrorFromNotification(NSNotification *notification) {
    NSError *error = notification.userInfo[AFNetworkingTaskDidCompleteErrorKey];
    return error;
}

static NSString *AFNetworkResponseTextFromNotification(NSNotification *notification) {
    NSData *data = notification.userInfo[AFNetworkingTaskDidCompleteResponseDataKey];
    NSString *responseText;
    if (data) {
        responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }

    return responseText;
}

@implementation AFNetworkLogger

+ (instancetype)sharedLogger {
    static AFNetworkLogger *_sharedLogger = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLogger = [[self alloc] init];
    });

    return _sharedLogger;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.level = AFLoggerLevelInfo;

    return self;
}

- (void)dealloc {
    [self stopLogging];
}

- (void)startLogging {
    [self stopLogging];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidStart:) name:AFNetworkingTaskDidResumeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
}

- (void)stopLogging {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotification

static void *AFNetworkRequestStartDate = &AFNetworkRequestStartDate;

- (void)networkRequestDidStart:(NSNotification *)notification {
    NSURLRequest *request = AFNetworkRequestFromNotification(notification);

    if (!request) {
        return;
    }

    if (self.filterPredicate && [self.filterPredicate evaluateWithObject:request]) {
        return;
    }

    objc_setAssociatedObject(notification.object, AFNetworkRequestStartDate, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    NSString *body = nil;
    if ([request HTTPBody]) {
        body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    }

    switch (self.level) {
        case AFLoggerLevelDebug:
            UALog(@"%@ '%@': %@ \n %@", [request HTTPMethod], [[request URL] absoluteString], [request allHTTPHeaderFields], body);
            break;
        case AFLoggerLevelInfo:
            UALog(@"%@ '%@'", [request HTTPMethod], [[request URL] absoluteString]);
            break;
        default:
            break;
    }
}

- (void)networkRequestDidFinish:(NSNotification *)notification {
    NSURLRequest *request = AFNetworkRequestFromNotification(notification);
    NSURLResponse *response = [notification.object response];
    NSError *error = AFNetworkErrorFromNotification(notification);

    if (!request && !response) {
        return;
    }

    if (request && self.filterPredicate && [self.filterPredicate evaluateWithObject:request]) {
        return;
    }

    NSUInteger responseStatusCode = 0;
    NSDictionary *responseHeaderFields = nil;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseStatusCode = (NSUInteger) [(NSHTTPURLResponse *) response statusCode];
        responseHeaderFields = [(NSHTTPURLResponse *) response allHeaderFields];
    }

    NSString *reponseText = AFNetworkResponseTextFromNotification(notification);
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(notification.object, AFNetworkRequestStartDate)];

    if (error) {
        switch (self.level) {
            case AFLoggerLevelDebug:
            case AFLoggerLevelInfo:
            case AFLoggerLevelWarn:
            case AFLoggerLevelError:
                UALog(@"[Error] %@ '%@' (%ld) [%.04f s]: \n %@", [request HTTPMethod], [[response URL] absoluteString], (long) responseStatusCode, elapsedTime, error);
            default:
                break;
        }
    } else {
        switch (self.level) {
            case AFLoggerLevelDebug:
                UALog(@"%ld '%@' [%.04f s]:\n %@ \n %@", (long) responseStatusCode, [[response URL] absoluteString], elapsedTime, responseHeaderFields, reponseText);
                break;
            case AFLoggerLevelInfo:
                UALog(@"%ld '%@' [%.04f s]", (long) responseStatusCode, [[response URL] absoluteString], elapsedTime);
                break;
            default:
                break;
        }
    }
}

@end
