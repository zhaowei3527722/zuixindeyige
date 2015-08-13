//
//  CommUtils.h
//  WeiSpoken
//
//  Created by osx mac on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
@interface CommUtils : NSObject

+(AppDelegate *) appDeletegate;
+(BOOL)isJailbroken;
+(NSString *)getsippw;
+ (void)showWaitWithTitle:(NSString *)title;
//+ (void)hideWaitNote;
+ (void)showMessageWithStr:(NSString*)str;
+ (NSString *)md5:(NSString *)str;
+ (BOOL) validateNumber: (NSString *) candidate;
+ (BOOL) validateEmail: (NSString *) candidate;
+ (BOOL)validatePwd:(NSString *)string;
+(BOOL)validateHour:(NSString *)string;
+(BOOL)validateMin:(NSString *)string;
+(BOOL)validateYue:(NSString *)string;
+(BOOL)validateRi:(NSString *)string;
+(NSString *)imsgeUrlWith:(NSString *)_imageurl;
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
+(BOOL)validatePhoneNumber:(NSString *)str;


@end
