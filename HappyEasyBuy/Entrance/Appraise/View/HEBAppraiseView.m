//
//  HEBAppraiseView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAppraiseView.h"
#import <KSPhotoBrowser.h>
#import "HEBPackageDetailsAppraiseView.h"
#import "HEBShopDetailsViewController.h"
#import "HEBTakOutDetailViewController.h"
#import "HEBHotelDetailViewController.h"

@interface HEBAppraiseView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@end

@implementation HEBAppraiseView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allCommentsArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HEBPackageDetailsAppraiseModel *model = self.allCommentsArrM[indexPath.row];
    return 44+model.content.heightWith14_90+70+(model.icon.count?(SCREEN_WIDTH/6):0)+(model.status?(60+model.reply_cont.heightWith14_90):0);;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dividingLine = YES;
    __weak __typeof(self)weakSelf = self;
    HEBPackageDetailsAppraiseModel *model = self.allCommentsArrM[indexPath.row];
    HEBPackageDetailsAppraiseView *appraiseView = [[HEBPackageDetailsAppraiseView alloc] init];
    [cell.contentView addSubview:appraiseView];
    [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    [appraiseView.header yy_setImageWithURL:[NSURL URLWithString:model.headimg] options:YYWebImageOptionProgressive];
    appraiseView.userName.text = model.name;
    appraiseView.time.text = model.time;
    [appraiseView.start displayRating:model.score];
    appraiseView.msg.text = model.content;
    appraiseView.respond.hidden = !model.status;
    appraiseView.bg.hidden = !model.status;
    QMUIButton *shop = [[QMUIButton alloc] init];
    shop.backgroundColor = UIColorHex(#f1f1f1);
    shop.tag = indexPath.row;
    [shop addTarget:self action:@selector(shopDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [appraiseView addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(appraiseView);
        make.top.equalTo((model.icon.count?appraiseView.imgArrM.lastObject:appraiseView.msg).mas_bottom).offset(20);
        make.height.mas_offset(44);
    }];
    UIImageView *shopicon = [[UIImageView alloc] init];
    [shopicon yy_setImageWithURL:[NSURL URLWithString:model.shop_logo.lastObject] options:YYWebImageOptionProgressive];
    [shop addSubview:shopicon];
    [shopicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shop.mas_centerY);
        make.left.equalTo(appraiseView.userName.mas_left);
        make.size.equalTo(shop.mas_height).multipliedBy(0.8);
    }];
    QMUILabel *shopName = [[QMUILabel alloc] init];
    shopName.text = model.shop_name;
    shopName.font = UIFontMake(16);
    shopName.textColor = BASEBLACK;
    [shop addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopicon.mas_centerY);
        make.left.equalTo(shopicon.mas_right).offset(5);
    }];
    if (model.status) {
        appraiseView.shopMsg.text = model.reply_cont;
        [appraiseView.shopMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shop.mas_bottom).offset(35);
            make.left.equalTo(appraiseView.header.mas_centerX).offset(5);
            make.right.equalTo(appraiseView.mas_right).offset(-15);
        }];
    }
    if (model.icon.count) {
        @weakify(appraiseView);
        NSMutableArray<KSPhotoItem *> *items = [NSMutableArray array];
        [model.icon enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:weak_appraiseView.imgArrM[idx] imageUrl:[NSURL URLWithString:obj]];
            [items addObject:item];
            [weak_appraiseView.imgArrM[idx] yy_setImageWithURL:[NSURL URLWithString:obj] options:YYWebImageOptionProgressive];
            [weak_appraiseView.imgArrM[idx] setUserInteractionEnabled:YES];
            [weak_appraiseView.imgArrM[idx] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:idx];
                [browser showFromViewController:weakSelf.viewController];
            }]];
        }];
    }else {
        [appraiseView.imgArrM enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [appraiseView.imgArrM removeAllObjects];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)shopDidClick:(QMUIButton *)sender {
    HEBPackageDetailsAppraiseModel *model = self.allCommentsArrM[sender.tag];
    if (model.type == 1) {
        HEBShopDetailsViewController *shop = [[HEBShopDetailsViewController alloc] init];
        shop.shop_id = model.shopid;
        [self.viewControl.navigationController pushViewController:shop animated:YES];
    }
    if (model.type == 4) {
        HEBHotelDetailViewController *hotel = [[HEBHotelDetailViewController alloc] init];
        hotel.hotelid = model.shopid;
        [self.viewControl.navigationController pushViewController:hotel animated:YES];
    }
    if (model.type == 5) {
        HEBTakOutDetailViewController *takeout = [[HEBTakOutDetailViewController alloc] init];
        takeout.shop_id = model.shopid;
        [self.viewControl.navigationController pushViewController:takeout animated:YES];
    }
}

- (NSMutableArray<HEBPackageDetailsAppraiseModel *> *)allCommentsArrM {
    if (!_allCommentsArrM) {
        _allCommentsArrM = [NSMutableArray array];
    }
    return _allCommentsArrM;
}

@end
