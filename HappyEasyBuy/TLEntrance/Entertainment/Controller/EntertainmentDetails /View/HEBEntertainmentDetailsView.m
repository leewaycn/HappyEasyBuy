//
//  HEBEntertainmentDetailsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBEntertainmentDetailsView.h"
#import "HEBEntertainmentDetailsTableViewCell.h"
#import "HEBGroupBuyDetailsVC.h"
@interface HEBEntertainmentDetailsView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBEntertainmentDetailsView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBEntertainmentDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBEntertainmentDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    HEBEntertainmentDetailsListModel *model = self.cellModelArr[indexPath.row];
    [cell setCellINFO];
    cell.bottomLine = YES;
    [cell.iconImage yy_setImageWithURL:[NSURL URLWithString:model.imgurl] options:YYWebImageOptionProgressive];
    cell.nameLabel.text = model.f_name;
    cell.pricLabel.text = [NSString stringWithFormat:@"%@元起", model.f_price];
    cell.sellLabe.text = [NSString stringWithFormat:@"已售%@", model.f_sold];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
    NSLog(@"%zd",indexPath.row);
    HEBEntertainmentDetailsListModel *model = self.cellModelArr[indexPath.row];
    HEBGroupBuyDetailsVC *groupBuyDetailsVC = [HEBGroupBuyDetailsVC new];
    groupBuyDetailsVC.f_id = self.cellModelArr[indexPath.row].f_id;
    groupBuyDetailsVC.lat = self.entertainmentDetailsModel.lat;
    groupBuyDetailsVC.lng = self.entertainmentDetailsModel.lng;
    groupBuyDetailsVC.f_price = model.f_price;
    groupBuyDetailsVC.f_pic = model.f_pic;
       [self.viewController.navigationController pushViewController:groupBuyDetailsVC animated:YES];
}

- (NSArray<HEBEntertainmentDetailsListModel *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSArray array];
    }
    return _cellModelArr;
}

@end
