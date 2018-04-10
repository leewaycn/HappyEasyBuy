//
//  HEBHappyMoneyTopUpView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUICollectionView.h"
#import "HEBHappyMoneyTopUpModel.h"

@interface HEBHappyMoneyTopUpView : QMUICollectionView

@property(nonatomic, strong) NSArray<HEBHappyMoneyTopUpModel *> *modelArr;

@property(nonatomic, copy) void (^getHappyMoney)(NSString *moeny);

@end
