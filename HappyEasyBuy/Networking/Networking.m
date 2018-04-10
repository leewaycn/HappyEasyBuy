//
//  Networking.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "Networking.h"
#import <DWNetworking.h>

@implementation Networking

+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id response, MainModel *mainModel, NSError *errorData))callBack {
    [DWNetworking networkEnvironmentChange:^(DWNetworkReachabilityStatus reachabilityStatus) {
        if (reachabilityStatus == DWNetworkReachabilityStatusReachableViaWWAN || reachabilityStatus == DWNetworkReachabilityStatusReachableViaWiFi) {
            [DWNetworking postUrlString:url params:params resultCallBack:^(id success, NSError *error, BOOL isCache) {
                if (!error) {
                    callBack(success, [MainModel yy_modelWithJSON:success], nil);
                }else {
                    callBack(success, nil, error);
                }
            }];
        }else {
            callBack(nil, nil, [NSError errorWithDomain:@"无网络连接" code:-1001 userInfo:nil]);
            [ISMessages showCardAlertWithTitle:@"网络错误"
                                       message:@"当前无网络连接..."
                                      duration:1.25
                                   hideOnSwipe:NO
                                     hideOnTap:YES
                                     alertType:ISAlertTypeError
                                 alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

@end
