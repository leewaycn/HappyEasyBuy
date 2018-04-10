//
//  UIImage+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/6.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "UIImage+HEBExtension.h"

@implementation UIImage (HEBExtension)
@dynamic base64Encoding;

- (NSString *)base64Encoding {
    NSData *imageData = nil;
    NSString *mimeType = nil;
    imageData = UIImageJPEGRepresentation(self, 0.3f);
    mimeType = @"image/jpeg";
    return [imageData base64EncodedStringWithOptions:0];
}

- (void)uploadIMGWithCallBack:(void(^)(id response, NSString *urlString, NSError *errorData))callBack {
    [Networking postUrl:UpLoadImg params:@{@"pic":self.base64Encoding} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            callBack(response, mainModel.data, errorData);
        }else {
            callBack(response, nil, errorData);
        }
        
    }];
}

@end
