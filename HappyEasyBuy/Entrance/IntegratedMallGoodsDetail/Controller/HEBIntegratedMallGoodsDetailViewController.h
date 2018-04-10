//
//  HEBGoodDetailViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEBIntegratedMallGoodsDetailViewController : HEBBaseViewController

/** 商品id */
@property(nonatomic, copy) NSString *objid;

/** 商品类型（0为虚拟1为实物） */
@property(nonatomic, copy) NSString *model;

@end
