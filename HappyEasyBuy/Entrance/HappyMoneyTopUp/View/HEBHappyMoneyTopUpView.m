//
//  HEBHappyMoneyTopUpView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyTopUpView.h"
#import "HEBOrderPayViewController.h"

@interface HEBHappyMoneyTopUpView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end


static NSString *const kIdentifier = @"Identifier";
@implementation HEBHappyMoneyTopUpView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = UIColorWhite;
    [cell.contentView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.mas_top).offset(5);
        make.bottom.equalTo(cell.contentView.mas_bottom).offset(-2.5);
        make.left.equalTo(cell.contentView.mas_left).offset(5);
        make.right.equalTo(cell.contentView.mas_right).offset(-5);
    }];
    bg.layer.cornerRadius = 10;
    bg.layer.masksToBounds = YES;
    bg.layer.borderColor = BASECOLOR.CGColor;
    bg.layer.borderWidth = 1;
    HEBHappyMoneyTopUpModel *model = self.modelArr[indexPath.row];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    money.text = model.c_full;
    money.font = UIFontMake(16);
    money.textColor = BASECOLOR;
    [bg addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg.mas_centerX);
        make.top.equalTo(bg.mas_top).offset(15);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.font = UIFontMake(16);
    msg.textColor = BASECOLOR;
    msg.text = [NSString stringWithFormat:@"到账%@个", model.c_reduce];
    msg.textAlignment = NSTextAlignmentCenter;
    [bg addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bg.mas_bottom).offset(-5);
        make.left.right.equalTo(bg);
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HEBHappyMoneyTopUpModel *model = self.modelArr[indexPath.row];
    HEBOrderPayViewController *order = [[HEBOrderPayViewController alloc] init];
    order.isHiddenHeader = YES;
    order.vcTitle = @"乐享币充值";
    order.vcPayMsg = [NSString stringWithFormat:@"  支付: %@", model.c_full];
    order.pay_price = model.c_full;
    order.consume_num = model.c_reduce;
    @weakify(order);
    order.paySuccess = ^{
        [weak_order.navigationController popViewControllerAnimated:YES];
        if (self.getHappyMoney) {
            self.getHappyMoney(model.c_reduce);
        }
    };
    [self.viewControl.navigationController pushViewController:order animated:YES];
}

@end
