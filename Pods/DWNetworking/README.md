# DWNetworking

---
[![CocoaPods](http://img.shields.io/cocoapods/v/DWNetworking.svg?style=flat)](http://cocoapods.org/?q=DWNetworking)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/DWNetworking.svg?style=flat)](http://cocoapods.org/?q=DWNetworking)&nbsp;
[![License](https://img.shields.io/cocoapods/l/DWNetworking.svg?style=flat)](http://cocoapods.org/pods/DWNetworking) 
[![GitHub stars](https://img.shields.io/github/stars/CoderDwang/DWNetworking.svg)](https://github.com/asiosldh/DWNetworking/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/CoderDwang/DWNetworking.svg)](https://github.com/asiosldh/DWNetworking/forkgazers)

![logo](https://github.com/CoderDwang/DWNetworking/blob/master/logo.png)

- 基于```AFNetworking~>3.1.0``` & ```YYCache~>1.0.4```
- ```轻量级``` & ```可定制```
- Cocoapods```pod 'DWNetworking'```
- 最低支持版本```iOS 8.0```
- 交流群```577506623```
- 自动选择是否使用```baseUrl```更加方便

![QQ群](https://github.com/CoderDwang/DWNetworking/blob/master/QQ群.png)

---
> 在```Applegate.h```中进行网络初始化配置,导入头文件```DWNetworking```

    //设置基础url
    //(如果有多处不同基础url，
    //此段代码也可不加，每次请求即需传入完整url)
    [DWNetworking setBaseUrlString:@"设置基础url"];

    //设置请求参数与返回参数类型
    //(此处为默认数据，可不加此数据)
    [DWNetworking setConfigRequestType:DWRequestTypePlainText responseType:DWResponseTypeJSON];
    
    //设置返回缓存数据时是否隐藏error信息/默认不隐藏
    [DWNetworking setReturnCacheHiddenError:YES];
    
    //设置是否自动使用缓存
    //即为请求失败或者当前无网络连接，
    //如果缓存中有数据则返回缓存数据，
    //无数据则走失败接口
    //(此处为默认数据，可不加此数据)
    [DWNetworking setAutoUseCache:YES];

    //设置不使用缓存的url
    //此url为发送请求时的url
    [DWNetworking setNotAutoUseCacheUrls:arr];
    
    //如果想要显示网络状态指示器，则需加入以下代码
    导入头文件
    #import "AFNetworkActivityIndicatorManager.h"
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    //网络状态
    [DWNetworking networkEnvironmentChange:^(DWNetworkReachabilityStatus reachabilityStatus) {
        NSLog(@"%ld", reachabilityStatus);
    }];

> 设置自动清除缓存上限,单位为kb

    [DWNetworking setAutoCleanCacheSize:1024];

> 获取当前缓存，此缓存计算方式为使用文件夹计算

    [DWNetworking getCachesSize];

> 清除缓存

    [DWNetworking cleanAllCache];

> GET请求

    [DWNetworking getUrlString:@"请求地址"
     params:@{@"请求参数":@"可为空"} 
     resultCallBack:^(id success, NSError *error) {}];

> POST请求

    [DWNetworking postUrlString:@"请求地址"
     params:@"请求参数"
      resultCallBack:^(id success, NSError *error) {}];

> 单图上传

    [DWNetworking uploadWithImage:图片对象 
    url:@"上传地址" 
    fileName:@"文件名，带后缀"
     name:@"与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles" 
     imageType:@"图片类型" parameters:@"请求参数" progress:^(NSProgress *progress) {} 
     resultCallBack:^(id success, NSError *error) {}]

> 多图上传，参数与单图相似，只不过是以数组存在

    [DWNetworking uploadWithImages:<(NSArray<UIImage *> *)> 
    url:<(NSString *)>
     fileNames:<(NSArray<NSString *> *)> 
     names:<(NSArray<NSString *> *)> 
     imageType:<(NSString *)> 
     parameters:<(NSDictionary *)> 
     progress:<^(NSProgress *progress)progress> 
     resultCallBack:<^(id success, NSError *error)resultCallBack>];


