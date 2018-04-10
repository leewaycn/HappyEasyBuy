//
//  Networking.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainModel.h"

@interface Networking : NSObject

+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id response, MainModel *mainModel, NSError *errorData))callBack;

@end
