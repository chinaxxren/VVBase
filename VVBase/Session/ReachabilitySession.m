//
// Created by Jiangmingz on 2016/6/30.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//


#import "ReachabilitySession.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "Reachability.h"

@interface ReachabilitySession ()

@property(nonatomic, strong) Reachability *reachability;

@property(nonatomic, strong) NSArray *typeStrings4G;
@property(nonatomic, strong) NSArray *typeStrings3G;
@property(nonatomic, strong) NSArray *typeStrings2G;

@end

@implementation ReachabilitySession

- (instancetype)init {
    self = [super init];
    if (self) {
        _typeStrings2G = @[CTRadioAccessTechnologyEdge,
                CTRadioAccessTechnologyGPRS,
                CTRadioAccessTechnologyCDMA1x];

        _typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                CTRadioAccessTechnologyWCDMA,
                CTRadioAccessTechnologyHSUPA,
                CTRadioAccessTechnologyCDMAEVDORev0,
                CTRadioAccessTechnologyCDMAEVDORevA,
                CTRadioAccessTechnologyCDMAEVDORevB,
                CTRadioAccessTechnologyeHRPD];

        _typeStrings4G = @[CTRadioAccessTechnologyLTE];

        self.reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        [self.reachability startNotifier];
    }

    return self;
}

+ (instancetype)share {
    static ReachabilitySession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[self alloc] init];
    });

    return session;
}

- (void)start {
    [self.reachability startNotifier];
}

- (ReachabilityStatus)netWorkStatus {
    NetworkStatus reachabilityStatus = [self.reachability currentReachabilityStatus];
    ReachabilityStatus status;
    if (reachabilityStatus == ReachableViaWiFi) {
        status = RealStatusViaWiFi;
    } else if (reachabilityStatus == ReachableViaWWAN) {
        status = RealStatusViaWWAN;
    } else {
        status = RealStatusNotReachable;
    }

    return status;
}

- (BOOL)isReachable {
    return [self netWorkStatus] == RealStatusViaWWAN || [self netWorkStatus] == RealStatusViaWiFi;
}

- (BOOL)isReachableViaWWAN {
    return [self netWorkStatus] == RealStatusViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    return [self netWorkStatus] == RealStatusViaWiFi;
}

- (NSString *)allReachability {
    if ([self isReachableViaWiFi]) {
        //wifi
        return @"2";
    }

    if ([self isReachableViaWWAN]) {
        CTTelephonyNetworkInfo *phonyNetwork = [[CTTelephonyNetworkInfo alloc] init];
        NSString *currentStr = phonyNetwork.currentRadioAccessTechnology;
        if ([currentStr length] == 0) {
            //无网
            return @"3";
        }

        if ([self.typeStrings4G containsObject:currentStr]) {
            //4g
            return @"6";
        } else if ([self.typeStrings3G containsObject:currentStr]) {
            //3g
            return @"5";
        } else if ([self.typeStrings2G containsObject:currentStr]) {
            //2g
            return @"4";
        } else {
            return @"3";
        }
    }

    return @"3";
}

- (NSString *)reachabilityString {
    if ([self isReachableViaWiFi]) {
        return @"WIFI";
    }

    if ([self isReachableViaWWAN]) {
        return @"CMNET";
    }

    return @"NONE";
}

@end
