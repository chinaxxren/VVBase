//
// Created by Jiangmingz on 2017/3/9.
// Copyright (c) 2017 zhaojiangming. All rights reserved.
//

#import "MMUserDefaults.h"

#define USER_ID @"user_id"

@implementation MMUserDefaults

+ (NSString *)userId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
}

@end
