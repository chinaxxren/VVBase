//
// Created by Jiangmingz on 2016/6/30.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ReachabilityStatus) {
    RealStatusNotReachable = 0,
    RealStatusViaWWAN = 1,
    RealStatusViaWiFi = 2
};

@interface ReachabilitySession : NSObject

+ (instancetype)share;

- (void)start;

- (ReachabilityStatus)netWorkStatus;

/**
 * 网络是否可用
 */
- (BOOL)isReachable;

/**
 * 网络是否为移动网络
 */
- (BOOL)isReachableViaWWAN;

/**
 * 网络是否为WiFi
 */
- (BOOL)isReachableViaWiFi;

- (NSString *)allReachability;

- (NSString *)reachabilityString;

@end
