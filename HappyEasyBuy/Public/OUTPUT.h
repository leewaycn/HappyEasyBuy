//
//  OUTPUT.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#ifndef OUTPUT_h
#define OUTPUT_h

#define BASEURLHOST @"http://luntan.guoxiangou.cn/index.php/"

/** 基础颜色 */
#define BASECOLOR   UIColorHex(#ff6800)
#define BASEBLACK   UIColorHex(#545454)

/** 获取导航栏高度 */
#define getNavigationHeight (IS_58INCH_SCREEN?88:64)

/** 获取TabBar高度 */
#define getTabBarHeight (IS_58INCH_SCREEN?83:49)

/** 城市ID */
#define getCity_id @"city_id".getUserDefaultsINFO

/** 经度 */
#define getLon     @"lon".getUserDefaultsINFO

/** 纬度 */
#define getLat     @"lat".getUserDefaultsINFO

/** 用户ID */
#define getUser_id @"userid".getUserDefaultsINFO

/** 用户手机号 */
#define getUser_phone @"userPhoneNumber".getUserDefaultsINFO

/** 用户密码，经过aes加密 */
#define getUser_passWord @"userPassWord".getUserDefaultsINFO

/** 持久化对象 */
#define selfClass(class) self.class = class
#define weakSelfClass(class) weakSelf.class = class

/** 微信appid */
#define WXID @"wx28cf3545de852ddb"

/** 支付宝id */
#define AliID @"2017093009012077"

/** 应用注册scheme */
#define AliAppScheme @"HappyEasyBuy"

#define JPUSHKEY @""

/** 获取列表数量 */
#define PAGE_SIZE_COUNT 20

/** 未登录的提示 */
#define ISAlertNotLoginMessage  [ISMessages showCardAlertWithTitle:@"操作失败" message:@"请登录之后再进行此操作" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil]

#ifdef DEBUG
/** NSLog(...) */
#define NSLog( s, ... ) NSLog( @"\n[所在方法:%s]\n[所在行数:%d]\n[打印内容:%@]", __func__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
/** NSLog(...) */
#define NSLog(...)
#endif

#endif /* OUTPUT_h */
