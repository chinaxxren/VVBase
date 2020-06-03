//
// Created by 赵江明 on 15/11/13.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StringUtils : NSObject

+ (BOOL)hasText:(NSString *)text;

+ (BOOL)isIp:(NSString *)text;

+ (NSString *)filterEmpty:(NSString *)text;

+ (NSString *)fileName:(NSString *)fullFileName;

+ (NSString *)fileName:(NSString *)entityId index:(NSInteger)index;

+ (NSString *)fileNameToDownloadId:(NSString *)fileName;

+ (NSString *)addP:(NSString *)text;

+ (NSString *)addPre:(NSString *)text;

+ (NSString *)addLive:(NSString *)text;

+ (NSString *)addUser:(NSString *)user;

+ (NSString *)addDynamicUser:(NSString *)text;

+ (NSString *)addZ:(NSString *)text;

+ (NSString *)addV:(NSString *)text;

+ (NSString *)addQ:(NSString *)text;

+ (NSString *)addKVC:(NSString *)text;

+ (NSString *)addPTC:(NSString *)text;

+ (NSString *)addBAIDU:(NSString *)text;

+ (NSString *)addHome:(NSString *)text;

+ (NSString *)addMP:(NSString *)text;

+ (NSString *)filterTitle:(NSString *)title;

+ (NSString *)addOp:(NSString *)text;

+ (NSString *)addCon:(NSString *)text;

+ (NSString *)addGonoCon:(NSString *)text;

+ (NSString *)addInmobi:(NSString *)text;

+ (NSString *)filterUserName:(NSString *)UserName;
@end
