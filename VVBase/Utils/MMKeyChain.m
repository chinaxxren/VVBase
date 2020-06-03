//
// Created by Jiangmingz on 16/4/28.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import "MMKeyChain.h"

#import <OpenUDID/OpenUDID.h>

#import "NSString+MD5.h"
#import "UICKeyChainStore.h"
#import "UALogger.h"

static NSString *KeyChainService = @"www.waqu.com";
static NSString *WQ_SID = @"wq_sid";

static NSString const *UDID;

@implementation MMKeyChain

+ (NSString *)sid {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sid = [userDefaults objectForKey:WQ_SID];
    if ([sid length] == 32) {
        return sid;
    }

    UICKeyChainStore *keyChainStore = [UICKeyChainStore keyChainStoreWithService:KeyChainService];
    sid = keyChainStore[WQ_SID];
    if ([sid length] > 0) {
        [userDefaults setObject:sid forKey:WQ_SID];
        [userDefaults synchronize];
        return sid;
    }

    sid = [OpenUDID value];
    sid = [sid md5];

    if ([sid length] > 0) {

        keyChainStore[WQ_SID] = sid;

        [userDefaults setObject:sid forKey:WQ_SID];
        [userDefaults synchronize];
    } else {
        UALog(@" openUDID error");
    }

    UALog(@" openUDID success %@", sid);
    return sid;
}

+ (NSString *)openUDID {
    if (!UDID) {
        UDID = [MMKeyChain sid];
    }

    return (NSString *)UDID;
}

@end
