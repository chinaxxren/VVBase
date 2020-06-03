//
// Created by 赵江明 on 15/11/13.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (BOOL)hasText:(NSString *)text {
    if (![text isKindOfClass:[NSString class]]) {
        return NO;
    }

    return [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] != 0;
}


+ (NSString *)filterEmpty:(NSString *)text {
    if ([self hasText:text]&&![text isEqualToString:@"(null)"]) {
        return text;
    }

    return @"";
}

+ (NSString *)fileName:(NSString *)fullFileName {
    if (![self hasText:fullFileName]) {
        return @"";
    }

    NSRange range = [fullFileName rangeOfString:@"." options:NSBackwardsSearch];
    if (range.length == 0) {
        return fullFileName;
    }

    return [fullFileName substringWithRange:NSMakeRange(0, range.location)];
}

+ (NSString *)fileName:(NSString *)entityId index:(NSInteger)index {
    if (![self hasText:entityId]) {
        return @"";
    }

    return [NSString stringWithFormat:@"%@.%ld", entityId, (long)index];
}

+ (NSString *)fileNameToDownloadId:(NSString *)fileName {
    if (![self hasText:fileName]) {
        return @"";
    }

    NSRange range = [fileName rangeOfString:@"." options:NSBackwardsSearch];
    if (range.length == 0) {
        return fileName;
    }

    return [fileName substringWithRange:NSMakeRange(0, range.location)];
}

+ (NSString *)addP:(NSString *)text {
    return [NSString stringWithFormat:@"%@_p", [self filterEmpty:text]];
}

+ (NSString *)addPre:(NSString *)text {
    return [NSString stringWithFormat:@"%@_pre", [self filterEmpty:text]];
}

+ (NSString *)addLive:(NSString *)text {
    return [NSString stringWithFormat:@"%@_live", [self filterEmpty:text]];
}

+ (NSString *)addUser:(NSString *)text {
    return [NSString stringWithFormat:@"%@_s_user", [self filterEmpty:text]];
}

+ (NSString *)addDynamicUser:(NSString *)text {
    return [NSString stringWithFormat:@"%@_tr_user", [self filterEmpty:text]];
}

+ (NSString *)addZ:(NSString *)text {
    return [NSString stringWithFormat:@"%@_z", [self filterEmpty:text]];
}

+ (NSString *)addV:(NSString *)text {
    return [NSString stringWithFormat:@"%@_v", [self filterEmpty:text]];
}

+ (NSString *)addQ:(NSString *)text {
    return [NSString stringWithFormat:@"%@_q", [self filterEmpty:text]];
}

+ (NSString *)addKVC:(NSString *)text {
    return [NSString stringWithFormat:@"%@_kvc", [self filterEmpty:text]];
}

+ (NSString *)addPTC:(NSString *)text {
    return [NSString stringWithFormat:@"%@_ptc", [self filterEmpty:text]];
}

+ (BOOL)isIp:(NSString *)text {
    NSString *number = @"([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];

    return [predicate evaluateWithObject:text];
}

+ (NSString *)addBAIDU:(NSString *)text {
    return [NSString stringWithFormat:@"%@_bdad", [self filterEmpty:text]];
}
+ (NSString *)addInmobi:(NSString *)text {
    return [NSString stringWithFormat:@"%@_imbad", [self filterEmpty:text]];
}

+ (NSString *)addHome:(NSString *)text {
    return [NSString stringWithFormat:@"phome_%@", [self filterEmpty:text]];
}

+ (NSString *)addMP:(NSString *)text {
    return [NSString stringWithFormat:@"%@_mp", [self filterEmpty:text]];
}

+ (NSString *)addOp:(NSString *)text {
    return [NSString stringWithFormat:@"%@_op", [self filterEmpty:text]];
}

+ (NSString *)addCon:(NSString *)text {
    return [NSString stringWithFormat:@"%@_con", [self filterEmpty:text]];
}

+ (NSString *)addGonoCon:(NSString *)text {
    return [NSString stringWithFormat:@"%@_pn_con", [self filterEmpty:text]];
}

+ (NSString *)filterTitle:(NSString *)title {
    if ([self hasText:title]) {
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"[\\\\;\\\\,\\\\#\\\\~\\\\:\\\\|\\\\！\\\\；\\\\：\\\\，]"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
        return [regular stringByReplacingMatchesInString:title options:NSMatchingReportProgress range:NSMakeRange(0, [title length]) withTemplate:@""];
    }

    return @"";
}

+ (NSString *)filterUserName:(NSString *)UserName{
    if ([self hasText:UserName]) {
        NSString *fixName;
        if (UserName.length > 8) {
            fixName = [NSString stringWithFormat:@"%@..", [UserName substringToIndex:7]];
        } else {
            fixName = UserName;
        }
        return fixName;
    }
    return @"";
}


@end
