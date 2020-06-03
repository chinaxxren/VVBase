//
// Created by Jiangmingz on 2016/12/22.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import "ApiParam.h"

#import "NSString+Validator.h"
#import "NSUserDefaults+User.h"

static NSString *GET = @"GET";
static NSString *POST = @"POST";

@interface ApiParam ()

@property(nonatomic, strong) NSMutableDictionary *fieldParam;
@property(nonatomic, strong) NSMutableDictionary *headerParam;

@end

@implementation ApiParam

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeout = 5;
        self.retries = 2;
        self.retrytime = 2;
        self.requestScheme = RequestNone;
    }

    return self;
}

+ (instancetype)inApi {
    ApiParam *apiParam = [ApiParam new];
    return apiParam;
}

+ (instancetype)outApi {
    ApiParam *apiParam = [ApiParam new];
    return apiParam;
}


- (BOOL)hasFieldParam {
    return [[_fieldParam allKeys] count] > 0;
}

- (NSMutableDictionary *)fieldParam {
    if (!_fieldParam) {
        _fieldParam = [NSMutableDictionary dictionary];
    }

    return _fieldParam;
}

- (BOOL)hasHeaderParam {
    return [[_headerParam allKeys] count] > 0;
}

- (NSMutableDictionary *)headerParam {
    if (!_headerParam) {
        _headerParam = [NSMutableDictionary dictionary];
    }
    
    return _headerParam;
}

- (void)setValue:(NSObject *)value forName:(NSString *)field {
    [[self fieldParam] setValue:value forKey:field];
}

- (void)setObject:(NSObject *)value forHeader:(NSString *)header {
    [[self headerParam] setValue:value forKey:header];
}

- (NSString *)method {
    if (self.requestMethod == Get) {
        return GET;
    } else if (self.requestMethod == Post) {
        return POST;
    }

    return GET;
}

@end
