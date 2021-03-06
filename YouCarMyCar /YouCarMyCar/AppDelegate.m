//
//  AppDelegate.m
//  YouCarMyCar
//
//  Created by LLY on 15-6-29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTaBarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/QZoneConnection.h>
#import "WXApi.h"
#import "DismissKeyboard.h"
#import "PrefixHeader.pch"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"message"]==nil){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key"];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"tishi"];

        ViewController *root = [[ViewController alloc]init];
        self.window.rootViewController = root;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"This_is_my_default_message" forKey:@"message"];
        
    }else {
        
        RootTaBarViewController *root = [[RootTaBarViewController alloc]init];
        self.window.rootViewController = root;
        
    }
    
    
    [self openTouchOutsideDismissKeyboard];//点击 空白的地方回收键盘
    [[UINavigationBar appearance] setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                          [UIFont  fontWithName:@"DBLCDTempBlack" size:24], NSFontAttributeName,
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          
                                                          nil]];
    
    //最上面字体白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //设置navigationbar 的颜色为蓝色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:235/255.0 green:50/255.0 blue:30/255.0 alpha:1]];
    //1.初始化ShareSDK应用
    [ShareSDK registerApp:@"89fd18586698"];
    
//    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:235/255.0 green:50/255.0 blue:30/255.0 alpha:1]];
     [[UITabBar appearance] setTintColor:[UIColor redColor]];
    

    self.window.backgroundColor = COLOR(251, 246, 240, 1);
    [self initPlat];//初始化平台
    
    return YES;
}

-(void)initPlat
{
    
    
    //初始化微信，微信开放平台上注册应用
    [ShareSDK connectWeChatWithAppId:@"wx8fa2fc1e94944e4f"
                           appSecret:@"8fb5f09bef01ba1140f322bc42bc85ef"
                           wechatCls:[WXApi class]];


//        //连接QQ应用
    [ShareSDK connectQQWithQZoneAppKey:@"1104741533"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectQZoneWithAppKey:@"1104741533"
                           appSecret:@"j5TfJT6LjjHDjkEU"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    
    //连接QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"1104741533"
                           appSecret:@"j5TfJT6LjjHDjkEU"
                   qqApiInterfaceCls:[QQApiInterface class]
                    tencentOAuthCls:[TencentOAuth class]];

    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectQZoneWithAppKey:@"1104741533"
//                           appSecret:@"j5TfJT6LjjHDjkEU"
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
//    
//    //    //开启QQ空间网页授权开关(optional), 开启授权一定要在上面注册方法之后
//    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
//    [app setIsAllowWebAuthorize:YES];
//    
//    [ShareSDK connectQZoneWithAppKey:@"100371282"
//                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
//    
//    //    //开启QQ空间网页授权开关(optional), 开启授权一定要在上面注册方法之后
//    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
//    [app setIsAllowWebAuthorize:YES];
    
    //初始化新浪，在新浪微博开放平台上申请应用z
    [ShareSDK connectSinaWeiboWithAppKey:@"3461543832"
                               appSecret:@"8e84173050311f230cd034780eb12dd1"
                             redirectUri:@"http://www.sharesdk.cn"
                             weiboSDKCls:[WeiboSDK class]];
    
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }


    

}
//添加两个回调方法,return的必须要ShareSDK的方法
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "C4A.ShareSDKEasyDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ShareSDKEasyDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ShareSDKEasyDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
