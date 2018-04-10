[![CocoaPods](http://img.shields.io/cocoapods/v/DWGuidePage.svg?style=flat)](http://cocoapods.org/?q=DWGuidePage)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/DWGuidePage.svg?style=flat)](http://cocoapods.org/?q=DWGuidePage)&nbsp;
[![License](https://img.shields.io/cocoapods/l/DWGuidePage.svg?style=flat)](http://cocoapods.org/pods/DWGuidePage) 
[![GitHub stars](https://img.shields.io/github/stars/dwanghello/DWGuidePage.svg)](https://github.com/asiosldh/DWGuidePage/stargazers)

- version
    - *0.0.2*
- Cocoapods
    - *pod 'DWGuidePage', '~> 0.0.2'*

---
![logo](https://github.com/dwanghello/DWGuidePage/blob/master/logo.png)

# 此项目使用Xcode8.1创建，低版本Xcode打开可能会无法使用
### *如果感觉不错，请给个Star支持一下*
#### *使用中如果遇到什么问题可以联系我*
##### *QQ群:577506623*
![QQ群](https://github.com/dwanghello/DWTransform/blob/master/QQ群.png)
##### *e-mail:dwang.hello@outlook.com*
![本地图片引导页](https://github.com/dwanghello/DWGuidePage/blob/master/DWGuidePageTest/本地图片引导页.gif)
---

# USE/使用
- 将<strong>DWGuidePage文件夹</strong>拖入到项目中
    
- 在<strong>appdelegate.m</strong>中引入头文件
    - *#import "DWGuidePage.h"*
    - *#import "引导页.h"*
    - *#import "首页.h"*
    
- 在<strong>- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {}</strong>  方法中加入以下代码
 >        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [DWGuidePage
     dw_AppDelegateGuidePageWindow:
     self.window 
     guidePageVC:[引导页 new]
      mainVC:[首页 new]];
      [self.window makeKeyAndVisible];

- 在引导页控制器中引入头文件
    - #import "DWGuidePage.h"
- 声明代理
    - <DWGuidePageDelegate>
- 初始化
    - DWGuidePage *guidePage = [[DWGuidePage alloc]initWithFrame:self.view.bounds];
- 遵循代理
    - guidePage.delegate = self;
- 设置内容
    - //imageArray:图片名与image对象可以用时使用
>    [guidePage dw_guidePageImageArray:@[@"IMG_1",
                 [UIImage imageNamed:@"IMG_2"], 
                 @"IMG_3",
                  [UIImage imageNamed:@"IMG_4"]] content:^(UIView *currentView, NSInteger currentPage, NSInteger count) {}];
- 执行代理方法//实时获取用户操作
>    - (void)dw_guidePageViewDidGuidePage:(double)guidePage 
            pageCount:(NSInteger)pageCount；


