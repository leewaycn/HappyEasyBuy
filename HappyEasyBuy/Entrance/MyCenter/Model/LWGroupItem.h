//
//  LWGroupItem.h
//  LWShopItem
//
//  Created by mac on 17/3/20.
//  Copyright © 2017年 LWShop.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWGroupItem : NSObject

//** 头部标题 headerTitle */
@property (nonatomic ,copy) NSString *headerTitle;

//** 尾部标题 headerTitle */
@property (nonatomic ,copy) NSString *footerTitle;

//** 一组中有几个元素 itemsArray */
@property (nonatomic ,strong) NSArray *itemsArray;



@end
