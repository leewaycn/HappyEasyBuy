//
//  HEBTakOutDetailShopActiveView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutShopActiveHeaderView.h"
#import <KSPhotoBrowser.h>

@implementation HEBTakOutShopActiveHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    QMUIButton *callPhone = [[QMUIButton alloc] init];
    selfClass(callPhone);
    callPhone.bottomLine = YES;
    [callPhone setImage:UIImageMake(@"联系") forState:UIControlStateNormal];
    [self addSubview:callPhone];
    [callPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.mas_offset(80);
        make.height.mas_offset(44);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(callPhone.mas_centerY);
        make.right.equalTo(callPhone.mas_left);
        make.width.mas_offset(1);
        make.height.equalTo(callPhone.mas_height).offset(-15);
    }];
    
    QMUIButton *address = [[QMUIButton alloc] init];
    selfClass(address);
    [address setImage:UIImageMake(@"定位") forState:UIControlStateNormal];
    [address setTitle:@"--" forState:UIControlStateNormal];
    [address setTitleColor:BASEBLACK forState:UIControlStateNormal];
    [self addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(callPhone);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(line.mas_left);
    }];
    address.bottomLine = YES;
    address.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    address.spacingBetweenImageAndTitle = 5;
    address.titleLabel.font = UIFontMake(14);
    address.titleLabel.numberOfLines = 2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.minimumLineSpacing = 12;
    layout.itemSize = CGSizeMake(135, 90);
    HEBTakOutShopPicView *shopPicView = [[HEBTakOutShopPicView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    selfClass(shopPicView);
    [self addSubview:shopPicView];
    [shopPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(address.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

@end
