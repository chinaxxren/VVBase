//
// Created by Jiangmingz on 2017/2/16.
//

#import <Foundation/Foundation.h>
#import "NetConstans.h"


@protocol ApiParamInterFace <NSObject>

- (NSUInteger)timeout;

- (NSUInteger)retries;

- (NSUInteger)retrytime;

- (BOOL)hasFieldParam;

- (NSMutableDictionary *)fieldParam;

- (BOOL)hasHeaderParam;

- (NSMutableDictionary *)headerParam;

- (NSString *)method;

- (NSString *)realFullPath;

@end