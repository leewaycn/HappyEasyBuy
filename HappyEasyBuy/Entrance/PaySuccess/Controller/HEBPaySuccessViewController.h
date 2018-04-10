//
//  HEBPaySuccessViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBPaySuccessViewController : HEBBaseViewController

/** 是否隐藏图片/默认为NO */
@property(nonatomic, assign, getter=isHiddenimg) BOOL Hiddenimg;

/** 点击完成回调 */
@property(nonatomic, copy) void (^success)(void);

/** 图片 */
@property(nonatomic, copy) NSString *imgName;

/** 所需价格 */
@property(nonatomic, copy) NSString *money;

/** 成功提示的文字 */
@property(nonatomic, copy) NSString *successMsg;

/** 需要显示的类目 */
@property(nonatomic, strong) NSArray<NSDictionary *> *cellModelArr;

@end
