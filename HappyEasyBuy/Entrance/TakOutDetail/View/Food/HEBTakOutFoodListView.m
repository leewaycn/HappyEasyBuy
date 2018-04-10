//
//  HEBTakOutFoodListView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutFoodListView.h"
#import "HEBTakOutFoodListCell.h"

@interface HEBTakOutFoodListView ()<QMUITableViewDataSource, QMUITableViewDelegate>

/** 临时存储sku模型 */
@property(nonatomic, strong) NSArray<HEBTakOutSKUModel *> *skuModelArr;

@end

@implementation HEBTakOutFoodListView

- (void)loadView {
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = UIColorWhite;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = UIColorHex(#f1f1f1);
    QMUILabel *name = [[QMUILabel alloc] init];
    name.text = self.name;
    name.font = UIFontMake(14);
    name.textColor = BASEBLACK;
    [header addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.mas_centerY);
        make.left.equalTo(header.mas_left).offset(15);
    }];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBTakOutFoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBTakOutFoodListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.bottomLine = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellINFO];
    HEBTakOutShopModel *model = self.foodListArr[indexPath.row];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
    cell.name.text = model.name;
    cell.price.text = [NSString stringWithFormat:@"¥ %@", model.price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@", model.oprice] attributes:attribtDic];
    cell.oprice.attributedText = attribtStr;
    cell.sku.titleLabel.font = model.sku.count?UIFontMake(14):UIFontMake(24);
    [cell.sku setTitle:model.sku.count?@"规格":@"+" forState:UIControlStateNormal];
    cell.sku.hidden = NO;
    cell.add.hidden = YES;
    cell.count.hidden = YES;
    cell.subtraction.hidden = YES;
    if (model.sku.count) {
        [cell.sku addTarget:self action:@selector(skuDidClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.sku.tag = indexPath.row;
    }else {
        if (model.num) {
            cell.sku.hidden = YES;
            cell.add.hidden = NO;
            cell.subtraction.hidden = NO;
            cell.count.hidden = NO;
            cell.count.text = [NSString stringWithFormat:@"%d", model.num];
        }else {
            @weakify(cell);
            @weakify(self);
            [cell.sku addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                weak_cell.sku.hidden = YES;
                weak_cell.add.hidden = NO;
                weak_cell.subtraction.hidden = NO;
                weak_cell.count.hidden = NO;
                weak_cell.count.text = @"1";
                weak_self.getNotSKUCoutChange(1, indexPath.row, model.food_id);
            }];
        }
    }
    @weakify(self);
    cell.getShopCountChange = ^(int count) {
        weak_self.getNotSKUCoutChange(count, indexPath.row, model.food_id);
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)skuDidClick:(QMUIButton *)sender {
    HEBTakOutSKUView *skuView = [[HEBTakOutSKUView alloc] init];
    [self.window addSubview:skuView];
    [skuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.window);
    }];
    [skuView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [skuView layoutIfNeeded];
    }];
    HEBTakOutShopModel *model = self.foodListArr[sender.tag];
    skuView.skuModelArr = [NSArray yy_modelArrayWithClass:[HEBTakOutSKUModel class] json:model.sku];
    [skuView loadAlertView];
    __weak __typeof(self)weakSelf = self;
    skuView.SKUModelArrChange = ^(NSArray<HEBTakOutSKUModel *> *skuModelArr, NSInteger idx, NSInteger count, NSString *sku) {
        HEBTakOutShopModel *shopModel = weakSelf.foodListArr[[sender tag]];
        [shopModel setSku:[skuModelArr yy_modelToJSONObject]];
        [weakSelf.foodListArr replaceObjectAtIndex:[sender tag] withObject:shopModel];
        if (weakSelf.getFoodListChnage) {
            weakSelf.getFoodListChnage([skuModelArr yy_modelToJSONObject], idx, sender.tag, model.food_id, count, sku);
        }
    };
}



- (NSMutableArray<HEBTakOutShopModel *> *)foodListArr {
    if (!_foodListArr) {
        _foodListArr = [NSMutableArray array];
    }
    return _foodListArr;
}

@end
