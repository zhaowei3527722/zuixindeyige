//
//  DismissKeyboard.h
//  点击空白处全局隐藏键盘
//
//  Created by ljc on 15/7/7.
//  Copyright (c) 2015年 ljc. All rights reserved.
//
/** 使用方法（so easy！）
  * 1.在AppDelegate.m 中 #import "DismissKeyboard.h"
  * 2.在 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
  *  加上[self openTouchOutsideDismissKeyboard];
 */
#import "AppDelegate.h"
@interface AppDelegate (DismissKeyboard)
/** 开启点击空白处隐藏键盘功能 */
- (void)openTouchOutsideDismissKeyboard;
@end
@implementation AppDelegate (DismissKeyboard)
/** 开启点击空白处隐藏键盘功能 */
- (void)openTouchOutsideDismissKeyboard
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addGesture) name:UIKeyboardDidShowNotification object:nil];
}
- (void)addGesture
{
    [self.window addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearKeyboard)]];
}
- (void)disappearKeyboard
{
    [self.window endEditing:YES];
    [self.window removeGestureRecognizer:self.window.gestureRecognizers.lastObject];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end