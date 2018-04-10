//
//  HEBPostCommentsViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBPostCommentsViewController : HEBBaseViewController

/** 商铺ID */
@property(nonatomic, copy) NSString *shop_id;

/** 订单号 */
@property(nonatomic, copy) NSString *orderNumber;

/** 商铺类型 */
@property(nonatomic, copy) NSString *type;

/** 评论成功 */
@property(nonatomic, copy) void (^CommentSuccess)(void);

@end
