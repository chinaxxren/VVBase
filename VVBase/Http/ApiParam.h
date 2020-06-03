//
// Created by Jiangmingz on 2016/12/22.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConstans.h"
#import "ApiParamInterFace.h"

@interface ApiParam : NSObject <ApiParamInterFace>

@property(nonatomic, copy) NSString *base;
@property(nonatomic, copy) NSString *host;
@property(nonatomic, copy) NSString *path;
@property(nonatomic, copy) NSString *scheme;
@property(nonatomic, copy) NSString *realFullPath;

@property(nonatomic, assign) RequestSerializer requestSerializer;
@property(nonatomic, assign) ResponseSerializer responseSerializer;

@property(nonatomic, assign) RequestMethod requestMethod;
@property(nonatomic, assign) RequestScheme requestScheme;
@property(nonatomic, assign) PathType pathType;

@property(nonatomic, assign) NSUInteger timeout;
@property(nonatomic, assign) NSUInteger retrytime;
@property(nonatomic, assign) NSUInteger retries;
@property(nonatomic, assign) BOOL hasDNS;

+ (instancetype)inApi;

+ (instancetype)outApi;

- (void)setValue:(NSObject *)value forName:(NSString *)field;

- (void)setObject:(NSObject *)value forHeader:(NSString *)header;

@end
