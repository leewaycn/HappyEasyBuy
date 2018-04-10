//
//  UIImage+HEBExtension.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/6.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HEBExtension)

/** 图片进行base64编码 */
@property(nonatomic, strong, readonly) NSString *base64Encoding;

/** 上传图片 */
- (void)uploadIMGWithCallBack:(void(^)(id response, NSString *urlString, NSError *errorData))callBack;

@end
