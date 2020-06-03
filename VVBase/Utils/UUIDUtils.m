//
// Created by 赵江明 on 15/11/12.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//

#import "UUIDUtils.h"


@implementation UUIDUtils

+ (NSString *)createUUID {
    return [[NSUUID UUID] UUIDString];
}

@end