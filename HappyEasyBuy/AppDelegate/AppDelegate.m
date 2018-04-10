//
//  AppDelegate.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "AppDelegate.h"
#import "HEBBaseTabBarViewController.h"
#import "HEBConfiguration.h"
#import <DWNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>

@interface AppDelegate ()<JPUSHRegisterDelegate, WXApiDelegate>
    
@end

@implementation AppDelegate
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadWindow];
    [self loadConfig];
    [self loadJPUSH:launchOptions];
    return YES;
}
    
- (void)loadWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[HEBBaseTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
}
    
- (void)loadConfig {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [DWNetworking setBaseUrlString:BASEURLHOST];
    [DWNetworking setTimeoutInterval:15];
    [HEBConfiguration setupConfigurationTemplate];
    [WXApi registerApp:WXID];
}
    
- (void)loadJPUSH:(id)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHKEY
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:nil];
    [JPUSHService crashLogON];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
        if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayResult" object:resultDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"balanceAliPay" object:resultDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayTopup" object:resultDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"transferAli" object:resultDic];
            }];
        }
        return [WXApi handleOpenURL:url delegate:self];
}
    
    // NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
    {
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayResult" object:resultDic];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"balanceAliPay" object:resultDic];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayTopup" object:resultDic];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"transferAli" object:resultDic];
            }];
        }
        return [WXApi handleOpenURL:url delegate:self];
    }
    
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}
    
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
    
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [JPUSHService crashLogON];
    completionHandler(UNNotificationPresentationOptionBadge);
}
    
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();
}
    
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
    
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}
    
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onResp:(BaseResp *)resp {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weChatPayResult" object:resp];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"balanceWeChatPay" object:resp];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weChatTopup" object:resp];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"transferWeCaht" object:resp];
}

@end

