//
//  HEBShippingAddressViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"
@class HEBLocationModel;

@interface HEBShippingAddressViewController : HEBBaseViewController

@property(nonatomic, strong) HEBLocationModel *locationModel;

/** 修改完成的信息 */
@property(nonatomic, copy) void (^locationChange)(HEBLocationModel *model);

/** 添加完成 */
@property(nonatomic, copy) void (^locationAddSuccess)(HEBLocationModel *model);

@end
