//
//  XLAppIconManager.m
//  XLDynamicAppIcon
//
//  Created by Mac-Qke on 2018/12/27.
//  Copyright © 2018 Mac-Qke. All rights reserved.
//

#import "XLAppIconManager.h"
#import "AppDelegate.h"
@implementation XLAppIconManager

+ (NSString *)getCurrentAppIconName {
    if (@available(iOS 10.3, *)) {
        return ([UIApplication sharedApplication].alternateIconName.length == 0) ? @"" : [UIApplication sharedApplication].alternateIconName;
    }else{
        // Fallback on earlier versions
        return @"";
    }
}


+ (BOOL)canChangeAppIcon {
    if (@available(iOS 10.3, *)) {
        return [[UIApplication sharedApplication] supportsAlternateIcons];
    }else{
        // Fallback on earlier versions
        return NO;
    }
}

+ (void)changeAppIconWithIconName:(NSString *)iconName completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                completionHandler(nil);
            } else {
                completionHandler(error);
            }
        }];
    }else{
        // Fallback on earlier versions
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"APPIcon change failed", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The current system version does not support replacing the AppIcon.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        NSError *error = [NSError errorWithDomain:@"" code:34001 userInfo:userInfo];
        completionHandler(error);
    }
}

@end
