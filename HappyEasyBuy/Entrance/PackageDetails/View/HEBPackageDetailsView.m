//
//  HEBPackageDetailsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPackageDetailsView.h"
#import "HEBPackageDetailsAppraiseView.h"
#import <KSPhotoBrowser.h>
#import "HEBAllCommentsViewController.h"

@interface HEBPackageDetailsView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBPackageDetailsView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBPackageDetailsHeaderView *header = [[HEBPackageDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220+(IS_58INCH_SCREEN?10:0))];
    selfClass(header);
    self.tableHeaderView = header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:section==1?self.articlesArr.count+1:section==3&&self.appraiseArr.count?self.appraiseArr.count+1:section==2?1:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row == self.appraiseArr.count) {
            return 44;
        }
         HEBPackageDetailsAppraiseModel *model = self.appraiseArr[indexPath.row];
        return model.content.heightWith14_90+70+(model.icon.count?(SCREEN_WIDTH/6):0)+(model.status?(60+model.reply_cont.heightWith14_90):0);
    }
    return indexPath.section==0?60:indexPath.section==1?30:indexPath.section==2?(self.useRules.heightWith12_30+self.useTime.heightWith12_30+self.aging.heightWith12_30+60+(3*17)+25):0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==1&&self.articlesArr.count?40:section!=3?40:10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return [UIView new];
    }
    NSArray <NSString *> *arr = @[@"    商家信息", @"    套餐", @"    购买须知"];
    UIView *header = [[UIView alloc] init];
    QMUILabel *lab = [[QMUILabel alloc] init];
    lab.font = UIFontMake(14);
    lab.textColor = UIColorGray;
    lab.backgroundColor = UIColorWhite;
    lab.text = arr[section];
    [header addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top).offset(10);
        make.left.right.bottom.equalTo(header);
    }];
    return header;
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
    cell.backgroundColor = UIColorWhite;
    __weak __typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        HEBPackageDetailsShopINFOView *shopINFO = [[HEBPackageDetailsShopINFOView alloc] init];
        selfClass(shopINFO);
        [cell.contentView addSubview:shopINFO];
        [shopINFO mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            QMUILabel *all = [[QMUILabel alloc] init];
            all.text = @"全部";
            all.textColor = BASEBLACK;
            all.font = UIFontMake(14);
            [cell.contentView addSubview:all];
            [all mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(cell.contentView);
            }];
        }else {
            [self loadArticlesViewWithModel:self.articlesArr[indexPath.row-1] andCell:cell];
        }
    }
    if (indexPath.section == 2) {
        [self loadUseRulesViewWithCell:cell];
    }
    if (indexPath.section == 3) {
        if (indexPath.row == self.appraiseArr.count) {
            cell.backgroundColor = UIColorClear;
            QMUIButton *lookMore = [[QMUIButton alloc] init];
            [lookMore setTitle:@"查看更多" forState:UIControlStateNormal];
            [lookMore setTitleColor:UIColorGray forState:UIControlStateNormal];
            [cell.contentView addSubview:lookMore];
            [lookMore mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
            [lookMore addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
               HEBAllCommentsViewController *vc = [[HEBAllCommentsViewController alloc] init];
                vc.shop_id = weakSelf.shop_id;
                [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
            }];
            return cell;
        }
        HEBPackageDetailsAppraiseModel *model = self.appraiseArr[indexPath.row];
        HEBPackageDetailsAppraiseView *appraiseView = [[HEBPackageDetailsAppraiseView alloc] init];
        [appraiseView.header yy_setImageWithURL:[NSURL URLWithString:model.headimg] options:YYWebImageOptionProgressive];
        appraiseView.userName.text = model.name;
        appraiseView.time.text = model.time;
        [appraiseView.start displayRating:model.score];
        appraiseView.msg.text = model.content;
        appraiseView.respond.hidden = !model.status;
        appraiseView.bg.hidden = !model.status;
        if (model.status) {
            appraiseView.shopMsg.text = model.reply_cont;
            [appraiseView.shopMsg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo((model.icon.count?appraiseView.imgArrM.lastObject:appraiseView.msg).mas_bottom).offset(35);
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
        [cell.contentView addSubview:appraiseView];
        [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dividingLine = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)loadArticlesViewWithModel:(HEBPackageDetailsArticlesModel *)model andCell:(QMUITableViewCell *)cell {
    QMUILabel *name = [[QMUILabel alloc] init];
    name.font = UIFontMake(14);
    name.textColor = BASEBLACK;
    name.text = model.t_name;
    [cell.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.right.equalTo(cell.contentView.mas_centerX);
    }];
    QMUILabel *num = [[QMUILabel alloc] init];
    num.font = UIFontMake(14);
    num.textColor = BASEBLACK;
    num.text = [NSString stringWithFormat:@"%@份", model.t_num];
    [cell.contentView addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_centerX).offset(15);
    }];
    QMUILabel *money = [[QMUILabel alloc] init];
    money.textAlignment = NSTextAlignmentLeft;
    money.font = UIFontMake(14);
    money.textColor = BASEBLACK;
    money.text = [NSString stringWithFormat:@"¥%@", model.t_price];
    [cell.contentView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
        make.width.mas_offset(80);
    }];
}

- (void)loadUseRulesViewWithCell:(QMUITableViewCell *)cell {
    QMUILabel *aginglab = [[QMUILabel alloc] init];
    aginglab.textColor = BASECOLOR;
    aginglab.font = UIFontMake(14);
    aginglab.text = @"有效期:";
    [cell.contentView addSubview:aginglab];
    [aginglab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.top.equalTo(cell.contentView.mas_top).offset(10);
    }];
    
    QMUILabel *aging = [[QMUILabel alloc] init];
    aging.textColor = BASEBLACK;
    aging.font = UIFontMake(12);
    aging.text = self.aging;
    [cell.contentView addSubview:aging];
    [aging mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aginglab.mas_bottom).offset(5);
        make.left.equalTo(aginglab.mas_left);
    }];
    
    QMUILabel *useTimelab = [[QMUILabel alloc] init];
    useTimelab.text = @"使用时间:";
    useTimelab.textColor = BASECOLOR;
    useTimelab.font = UIFontMake(14);
    [cell.contentView addSubview:useTimelab];
    [useTimelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aginglab.mas_left);
        make.top.equalTo(aging.mas_bottom).offset(10);
    }];
    
    QMUILabel *useTime = [[QMUILabel alloc] init];
    useTime.textColor = BASEBLACK;
    useTime.font = UIFontMake(12);
    useTime.text = self.useTime;
    [cell.contentView addSubview:useTime];
    [useTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(useTimelab.mas_bottom).offset(5);
        make.left.equalTo(aginglab.mas_left);
    }];
    
    QMUILabel *useRuleslab = [[QMUILabel alloc] init];
    useRuleslab.text = @"使用规则:";
    useRuleslab.textColor = BASECOLOR;
    useRuleslab.font = UIFontMake(14);
    [cell.contentView addSubview:useRuleslab];
    [useRuleslab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aginglab.mas_left);
        make.top.equalTo(useTime.mas_bottom).offset(10);
    }];
    QMUILabel *useRules = [[QMUILabel alloc] init];
    useRules.textColor = BASEBLACK;
    useRules.numberOfLines = 0;
    useRules.font = UIFontMake(12);
    useRules.text = self.useRules;
    [cell.contentView addSubview:useRules];
    [useRules mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(useRuleslab.mas_bottom).offset(5);
        make.left.equalTo(aginglab.mas_left);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
    }];
}

- (NSArray<HEBPackageDetailsArticlesModel *> *)articlesArr {
    if (!_articlesArr) {
        _articlesArr = [NSArray array];
    }
    return _articlesArr;
}

- (NSArray<HEBPackageDetailsAppraiseModel *> *)appraiseArr {
    if (!_appraiseArr) {
        _appraiseArr = [NSArray array];
    }
    return _appraiseArr;
}

@end
