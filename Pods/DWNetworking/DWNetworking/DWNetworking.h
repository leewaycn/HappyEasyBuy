//
//  DWNetworking.h
//  DWNetworking
//
//  Created by dawng on 2017/8/28.
//  Copyright © 2017年 CoderDwang. All rights reserved.
//*******************Github:https://github.com/CoderDwang/DWNetworking*************
//*******************QQ:739814184*********************************************
//*******************问题交流QQ群:577506623*************************************

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DWNetworking : NSObject

typedef NS_ENUM(NSUInteger, DWNetworkReachabilityStatus) {
    /** 未知状态 */
    DWNetworkReachabilityStatusUnknown = -1,
    /** 无网络连接 */
    DWNetworkReachabilityStatusNotReachable = 0,
    /** WWAN网络 */
    DWNetworkReachabilityStatusReachableViaWWAN = 1,
    /** WiFi网络 */
    DWNetworkReachabilityStatusReachableViaWiFi = 2
};

typedef NS_ENUM(NSUInteger, DWNetworkResponseType) {
    DWResponseTypeJSON = 0,
    DWBResponseTypeXML,
    DWBResponseTypeData
};

typedef NS_ENUM(NSUInteger, DWNetworkRequestType) {
    DWRequestTypeJSON = 0,
    DWRequestTypePlainText,
};

/**
 设置请求地址的基础url
 @param url 如http://www.baidu.com/
 */
+ (void)setBaseUrlString:(NSString *)url;

/**
 获取当前的基础url
 @return baseUrl
 */
+ (NSString *)baseUrlString;

/**
 设置请求类型
 @param requestType 请求类型
 @param responseType 返回类型
 */
+ (void)setConfigRequestType:(DWNetworkRequestType)requestType
                responseType:(DWNetworkResponseType)responseType;

/**
 设置请求头
 @param config 协商好的参数
 */
+ (void)setHttpHeaderConfig:(NSDictionary *)config;

/**
 设置请求超时
 @param time 超时时长/默认60s
 */
+ (void)setTimeoutInterval:(NSTimeInterval)time;

/**
 设置最大请求并发数
 @param count 默认3
 */
+ (void)setMaxConcurrentOperationCount:(NSInteger)count;

/**
 设置是否自动使用缓存/即为请求失败或者当前无网络连接，如果缓存中有数据则返回缓存数据，无数据则走失败接口
 @param cache 默认为YES
 */
+ (void)setAutoUseCache:(BOOL)cache;

/**
 设置不自动使用缓存的url地址
 @param urls 此地址为请求时输入的url
 */
+ (void)setNotAutoUseCacheUrls:(NSArray <NSString *>*)urls;

/**
 设置返回缓存数据时是否隐藏error信息(即为nil)

 @param hidden 默认为NO/不隐藏error信息
 */
+ (void)setReturnCacheHiddenError:(BOOL)hidden;

/**
 获取当前已有不使用缓存的url
 @return 已有地址
 */
+ (NSArray <NSString *> *)notAutoUseCacheUrl;

/**
 获取当前网络状态
 @param reachabilityStatus 网络状态码
 */
+ (void)networkEnvironmentChange:(void(^)(DWNetworkReachabilityStatus reachabilityStatus))reachabilityStatus;

/**
 取消全部请求
 */
+ (void)cancelAllTask;

/**
 获取缓存文件夹路径
 @return 文件路径
 */
+ (NSString *)getCachesPath;


/**
 设置自动清除缓存值上限
 @param size 当缓存>=size时自动清除
 */
+ (void)setAutoCleanCacheSize:(long long)size;

/**
 获取缓存大小
 @return 单位KB
 */
+ (long long)getCachesSize;

/**
 清除全部缓存
 */
+ (void)cleanAllCache;

/**
 GET
 @param url 请求地址
 @param params 请求参数/可为空
 @param resultCallBack 回调函数
 */
+ (void)getUrlString:(NSString *)url
              params:(NSDictionary *)params
      resultCallBack:(void(^)(id success, NSError *error, BOOL isCache))resultCallBack;

/**
 POST
 @param url 请求地址
 @param params 请求参数
 @param resultCallBack 回调函数
 */
+ (void)postUrlString:(NSString *)url
               params:(NSDictionary *)params
       resultCallBack:(void(^)(id success, NSError *error, BOOL isCache))resultCallBack;

/**
 单图上传
 @param image 图片对象
 @param url 上传地址
 @param fileName 文件名，带后缀
 @param name 与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 @param imageType image/jpeg
 @param parameters 参数
 @param progress 参数
 @param resultCallBack 回调函数
 */
+ (void)uploadWithImage:(UIImage *)image
                    url:(NSString *)url
               fileName:(NSString *)fileName
                   name:(NSString *)name
              imageType:(NSString *)imageType
             parameters:(NSDictionary *)parameters
               progress:(void(^)(NSProgress *progress))progress
         resultCallBack:(void(^)(id success, NSError *error))resultCallBack;

/**
 多图上传
 @param images 图片数组
 @param url 上传地址
 @param fileNames 文件名数组,带后缀
 @param names 与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 @param imageType image/jpeg
 @param parameters 参数
 @param progress 进度
 @param resultCallBack 回调函数
 */
+ (void)uploadWithImages:(NSArray<UIImage *>*)images
                     url:(NSString *)url
               fileNames:(NSArray<NSString *> *)fileNames
                   names:(NSArray<NSString *> *)names
               imageType:(NSString *)imageType
              parameters:(NSDictionary *)parameters
                progress:(void(^)(NSProgress *progress))progress
          resultCallBack:(void(^)(id success, NSError *error))resultCallBack;


@end
