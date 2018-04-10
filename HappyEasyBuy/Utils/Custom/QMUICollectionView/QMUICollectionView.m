//
//  QMUICollectionView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUICollectionView.h"

@implementation QMUICollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColorWhite;
        [self loadView];
    }
    return self;
}

- (void)loadView {
}

@end
