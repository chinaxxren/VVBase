//
// Created by Jiangmingz on 2017/2/14.
// Copyright (c) 2017 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, RequestSerializer) {
    HTTPRequestSerializer,
    JSONRequestSerializer,
};

typedef NS_ENUM(NSInteger, ResponseSerializer) {
    HTTPResponseSerializer,
    JSONResponseSerializer,
    CompoundResponseSerializer,
};

typedef NS_ENUM(NSInteger, RequestMethod) {
    Get,
    Post,
};

typedef NS_ENUM(NSInteger, RequestScheme) {
    RequestNone,
    RequestHttps,
    RequestHttp
};

typedef NS_ENUM(NSInteger, PathType) {
    RelativePath,
    AbsolutePath,
};

#define LOAD_DATA_END_NUMBER  @(-1)

@interface NetConstans : NSObject

extern NSString *const ERROR_DOMAIM;
extern NSString *const ERROR_MESSAGE;
extern NSString *const ERROR_OBJECT;
extern NSString *const ERROR_403;

@end
