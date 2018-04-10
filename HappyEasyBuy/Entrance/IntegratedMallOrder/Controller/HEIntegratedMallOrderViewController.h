//
//  HEBorderAffirmViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEIntegratedMallOrderViewController : HEBBaseViewController

/** 商品图片地址 */
@property(nonatomic, copy) NSString *imgUrl;

/** 商品名称 */
@property(nonatomic, copy) NSString *name;

/** 数量 */
@property(nonatomic, copy) NSString *count;

/** 积分 */
@property(nonatomic, copy) NSString *integral;

/** 是否为实物 */
@property(nonatomic, assign) BOOL isReal;

/** 商品id */
@property(nonatomic, copy) NSString *goods_id;

@end
