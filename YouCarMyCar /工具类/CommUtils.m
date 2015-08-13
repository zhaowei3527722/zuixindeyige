//
//  CommUtils.m
//  WeiSpoken
//
//  Created by osx mac on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommUtils.h"

@implementation CommUtils
+(AppDelegate *) appDeletegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
//是不是越狱设备
+(BOOL)isJailbroken {
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }  
    return jailbroken;  
}

+(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//判断手机号
+(BOOL)validatePhoneNumber:(NSString *)str

{
    
    if ([str length] == 0) {
        
        
        return NO;
        
    }
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
        
    }
    
    
    
    return YES;
    
}





//+ (void)showWaitWithTitle:(NSString *)title{
//	WaitNotView * waitNote = [self appDeletegate].waitView;
//	[waitNote setString:title];
//	waitNote.hidden = NO;
//	waitNote.alpha = 1;
//	[waitNote.activity startAnimating];
//}
//
//+ (void)hideWaitNote{
//	WaitNotView* waitNote = [self appDeletegate].waitView;
//    [UIView beginAnimations:nil	context:nil];
//    [UIView setAnimationDuration:0.3];
//   	waitNote.alpha = 0;
//	//waitNote.hidden = YES;
//    [UIView commitAnimations];
//    
//	[waitNote.activity stopAnimating];
//}



+(NSString *)imsgeUrlWith:(NSString *)_imageurl{
    return [NSString stringWithFormat:@"%@/%@",@"http://teacher.4000669696.com/",_imageurl];
}

//2299147101112168119863160146311316421613671221782352776126177229

//检查数字格式
+ (BOOL) validateNumber: (NSString *) candidate {
	NSString *format = @"[0-9]{1,15}";
	NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
	
	return [formatTest evaluateWithObject:candidate];
}
//检查邮箱格式
+ (BOOL) validateEmail: (NSString *) candidate {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
	return [emailTest evaluateWithObject:candidate];
}
//检查密码格式
+ (BOOL)validatePwd:(NSString *)string
{
    NSString *format = @"^[a-zA-Z0-9_]{6,20}$";
    NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [formatTest evaluateWithObject:string];
}

//检测小时格式
+(BOOL)validateHour:(NSString *)string
{
    NSString *format = @"^[0-24_]{1,2}$";
    NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [formatTest evaluateWithObject:string];
}
//检测分钟格式
+(BOOL)validateMin:(NSString *)string
{
    NSString *format = @"^[0-60_]{1,2}$";
    NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [formatTest evaluateWithObject:string];
}
//检测月格式
+(BOOL)validateYue:(NSString *)string
{
    NSString *format = @"^[0-12_]{1,2}$";
    NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [formatTest evaluateWithObject:string];
}
//检测日格式
+(BOOL)validateRi:(NSString *)string
{
    NSString *format = @"^[0-31_]{1,2}$";
    NSPredicate *formatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [formatTest evaluateWithObject:string];
}

//解析URL的编码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
