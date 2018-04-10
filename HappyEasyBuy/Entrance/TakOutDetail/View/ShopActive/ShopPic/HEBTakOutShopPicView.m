//
//  HEBTakOutShopPicView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutShopPicView.h"
#import <KSPhotoBrowser.h>
#import "HEBPicCell.h"

@interface HEBTakOutShopPicView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UIImageView *img;

@end

static NSString *const kReuseIdentifier = @"kReuseIdentifier";
@implementation HEBTakOutShopPicView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[HEBPicCell class] forCellWithReuseIdentifier:kReuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellModelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HEBPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell setCellINFO];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:self.cellModelArr[indexPath.row]] options:YYWebImageOptionProgressive];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray <KSPhotoItem *>*items = [NSMutableArray array];
    HEBPicCell *cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    [self.cellModelArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:cell.icon imageUrl:[NSURL URLWithString:obj]];
        [items addObject:item];
    }];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:indexPath.row];
    [browser showFromViewController:self.viewController];
}

@end
