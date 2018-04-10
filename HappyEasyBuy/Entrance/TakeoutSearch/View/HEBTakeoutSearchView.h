//
//  HEBTakeoutSearchView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBGuessYlikeModel.h"

@interface HEBTakeoutSearchView : QMUITableView

@property(nonatomic, strong) NSArray<HEBGuessYlikeModel *> *searchModelArr;

@end
