//
//  HEBBuyCarCargoView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/12.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBuyCarCargoView.h"
#import "HEBBuyCarCargoCell.h"
#import "HEBTakOutDetailModel.h"

@interface HEBBuyCarCargoView()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBBuyCarCargoView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBBuyCarCargoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBBuyCarCargoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.bottomLine = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HEBTakOutShopModel *model = self.foodListArr[indexPath.row];
    [cell setCellINFO];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
    cell.name.text = model.name;
    cell.sku.text = model.skuName;
    cell.price.text = [NSString stringWithFormat:@"¥ %@", model.skuPrice];
    cell.oprice.attributedText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@", model.oprice] attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    cell.count.text = [NSString stringWithFormat:@"%d", model.skuNum];
    __weak __typeof(self)weakSelf = self;
    cell.getShopCountChange = ^(int count) {
        [model setSkuNum:count];
        NSMutableArray<HEBTakOutShopModel *> *arrM = [NSMutableArray array];
        [weakSelf.foodListArr enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                [arrM addObject:model];
            }else {
                [arrM addObject:obj];
            }
        }];
        if (weakSelf.getBuyCarShopChange) {
            weakSelf.getBuyCarShopChange(arrM, NO, model.food_id, count, model.sku_sku);
        }
        if (!count) {
            [weakSelf.foodListArr removeObjectAtIndex:indexPath.row];
            if (!weakSelf.foodListArr.count) {
                [tableView reloadData];
                if (weakSelf.getBuyCarShopChange) {
                    weakSelf.getBuyCarShopChange(arrM, YES, model.food_id, count, model.sku_sku);
                }
            }else {
                [tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    };
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
   
}

- (NSMutableArray<HEBTakOutShopModel *> *)foodListArr {
    if (!_foodListArr) {
        _foodListArr = [NSMutableArray array];
    }
    return _foodListArr;
}

@end
