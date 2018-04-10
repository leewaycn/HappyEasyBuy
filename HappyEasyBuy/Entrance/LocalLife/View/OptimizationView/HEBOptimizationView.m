//
//  HEBOptimizationView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOptimizationView.h"
#import "HEBPicCell.h"

@interface HEBOptimizationView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

static NSString *const kReuseIdentifier = @"kReuseIdentifier";

@implementation HEBOptimizationView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[HEBPicCell class] forCellWithReuseIdentifier:kReuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.optimizationModelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HEBPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell setCellINFO];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:self.optimizationModelArr[indexPath.row].logo.firstObject] options:YYWebImageOptionProgressive];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.getOptimizationDidClick) {
        self.getOptimizationDidClick(self.optimizationModelArr[indexPath.row]);
    }
}

- (NSArray<HEBOptimizationModel *> *)optimizationModelArr {
    if (!_optimizationModelArr) {
        _optimizationModelArr = [NSArray array];
    }
    return _optimizationModelArr;
}

@end
