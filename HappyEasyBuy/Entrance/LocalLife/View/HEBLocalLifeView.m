//
//  HEBLocalLifeView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLocalLifeView.h"
#import "HEBGuessYlikeHeaderView.h"
#import "HEBGastronomyViewController.h"
#import "HEBVicinityViewController.h"
#import "HEBTakOutDetailViewController.h"
#import "HEBHotelViewController.h"
#import "HEBLeisureViewController.h"
#import "HEBCompanyViewController.h"

@interface HEBLocalLifeView ()<QMUITableViewDelegate, QMUITableViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation HEBLocalLifeView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    __weak __typeof(self)weakSelf = self;
    HEBCycleScrollView *cycleScrollView = [[HEBCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    selfClass(cycleScrollView);
    cycleScrollView.getCityName = ^(NSString *cityName) {
        if (weakSelf.getCityName) {
            weakSelf.getCityName(cityName);
        }
    };
    [cycleScrollView startLocationCycleScrollViewType:@"2"];
    self.tableHeaderView = cycleScrollView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:section==1||section==2?1:self.guessYlikeModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0?(self.classificationModelArr.count?200:0):indexPath.section==1?(self.hotSellModelArr.count?200:0):indexPath.section==2?(self.optimizationModelArr.count?140:0):80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section!=3?CGFLOAT_MIN:(self.hotSellModelArr.count || self.optimizationModelArr.count||self.guessYlikeModelArrM.count)?80:CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section!=3?8:CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3 && (self.optimizationModelArr.count || self.guessYlikeModelArrM.count || self.hotSellModelArr.count)) {
        __weak __typeof(self)weakSelf = self;
       HEBGuessYlikeHeaderView *guessYlikeHeaderViewHeader = [[HEBGuessYlikeHeaderView alloc] init];
        guessYlikeHeaderViewHeader.lab = @"猜你喜欢";
        guessYlikeHeaderViewHeader.sequencingMsg = weakSelf.sequencingMsg;
        [guessYlikeHeaderViewHeader loadHeaderView];
        @weakify(guessYlikeHeaderViewHeader);
        guessYlikeHeaderViewHeader.guessYlikeHeaderViewDidClick = ^(QMUIButton *sender) {
            if (weakSelf.sequencingView) {
                [weakSelf.sequencingView removeFromSuperview];
                weakSelf.sequencingView = nil;
                if (sender.tag == 100) {
                    return ;
                }
            }
            if (weakSelf.screeningView) {
                [weakSelf.screeningView removeFromSuperview];
                weakSelf.screeningView = nil;
                if (sender.tag == 103) {
                    return;
                }
            }
            if (sender.tag != 101 && sender.tag != 102) {
                if (tableView.contentSize.height/SCREEN_HEIGHT<2) {
                    [tableView setContentSize:CGSizeMake(0, SCREEN_HEIGHT*2-weak_guessYlikeHeaderViewHeader.height+22)];
                    [tableView layoutIfNeeded];
                }
                [UIView animateWithDuration:0.25 animations:^{
                    [tableView setContentOffset:CGPointMake(0, weak_guessYlikeHeaderViewHeader.top+35)];
                } completion:^(BOOL finished) {
                    [weakSelf loadScreeningView:(HEBGuessYlikeHeaderView *)weak_guessYlikeHeaderViewHeader btn:sender];
                }];
                return;
            }
            if (weakSelf.getguessYlikeDidClick) {
                weakSelf.getguessYlikeDidClick(sender);
            }
        };
        return guessYlikeHeaderViewHeader;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"%ld", indexPath.section];
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:{
            [self loadClassificationView:cell.contentView];
        }break;
        case 1:{
            if (self.hotSellModelArr.count)[self loadHotSellView:cell.contentView];
        }break;
        case 2:{
            if (self.optimizationModelArr.count)[self loadOptimizationView:cell.contentView];
        }
            break;
        case 3:{
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.dividingLine = YES;
         [self loadGuessYlikeView:cell.contentView withGuessYlikeModel:self.guessYlikeModelArrM[indexPath.row]];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)loadClassificationView:(UIView *)contentView {
    __weak __typeof(self)weakSelf = self;
    ClassificationsView *classificationsView = [[ClassificationsView alloc] init];
    NSMutableArray *arr = [NSMutableArray array];
    [self.classificationModelArr enumerateObjectsUsingBlock:^(HEBClassificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.objid.integerValue == 1 || obj.objid.integerValue == 5) {
            [arr addObject:obj];
        }
    }];
    [classificationsView setClassificationsViewDataArr:arr maxRowCount:5 maxRow:2 didClickClassifications:^(HEBClassificationModel *model) {
        switch (model.objid.intValue) {
            case 1:{
                HEBGastronomyViewController *gastronomyViewController = [[HEBGastronomyViewController alloc] init];
                gastronomyViewController.objid = model.objid;
                [weakSelf.viewController.navigationController pushViewController:gastronomyViewController animated:YES];
            }break;
            case 3:{
                HEBLeisureViewController *entertainmentViewController = [[HEBLeisureViewController alloc] init];
                [weakSelf.viewController.navigationController pushViewController:entertainmentViewController animated:YES];
            }break;
            case 4:{
                HEBHotelViewController *hotelViewController = [[HEBHotelViewController alloc] init];
                [weakSelf.viewController.navigationController pushViewController:hotelViewController animated:YES];
            }break;
            case 5:{
                HEBVicinityViewController *vicinity = [[HEBVicinityViewController alloc] init];
                vicinity.c_type = 5;
                [weakSelf.viewController.navigationController pushViewController:vicinity animated:YES];
            }break;
                
            case 7:{
                HEBCompanyViewController *companyVC = [[HEBCompanyViewController alloc] init];
                [weakSelf.viewController.navigationController pushViewController:companyVC animated:YES];
            }break;
            case 25: {
                HEBVicinityViewController *vicinity = [[HEBVicinityViewController alloc] init];
                vicinity.c_type = 25;
                vicinity.vcTitle = model.name;
                [weakSelf.viewController.navigationController pushViewController:vicinity animated:YES];
            }break;
            default:
                break;
        }
    }];
    [contentView addSubview:classificationsView];
    [classificationsView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(contentView);
    }];

}

- (void)loadHotSellView:(UIView *)contentView {
    HEBHotSellView *hotSellView = [[HEBHotSellView alloc] init];
    hotSellView.hotSellModelArr = self.hotSellModelArr;
    [contentView addSubview:hotSellView];
    [hotSellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(contentView);
    }];
    [self.hotSellModelArr enumerateObjectsUsingBlock:^(HEBHotSellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [hotSellView.hotSellIMGArrM[idx] yy_setImageWithURL:[NSURL URLWithString:obj.pic] options:YYWebImageOptionProgressive];
    }];
    
}

- (void)loadOptimizationView:(UIView *)contentView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.minimumLineSpacing = 12;
    layout.itemSize = CGSizeMake(135, 90);
    HEBOptimizationView *optimizationView = [[HEBOptimizationView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    optimizationView.optimizationModelArr = self.optimizationModelArr;
    optimizationView.showsHorizontalScrollIndicator = NO;
    optimizationView.showsVerticalScrollIndicator = NO;
    [contentView addSubview:optimizationView];
    [optimizationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView.mas_top).offset(30);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    UIView *header = [self optimizationHeaderView];
    [contentView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top);
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(optimizationView.mas_top);
    }];
    optimizationView.getOptimizationDidClick = ^(HEBOptimizationModel *model) {
        
    };
}

- (UIView *)optimizationHeaderView {
    UIView *header = [[UIView alloc] init];
    QMUILabel *lab = [[QMUILabel alloc] init];
    lab.text = @"为你优选";
    lab.font = UIFontMake(14);
    [header addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX);
        make.top.equalTo(header.mas_top).offset(10);
    }];
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = UIColorBlack;
    [header addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.right.equalTo(lab.mas_left).offset(-4);
        make.size.mas_offset(CGSizeMake(25, 1));
    }];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = UIColorBlack;
    [header addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.size.equalTo(leftLine);
        make.left.equalTo(lab.mas_right).offset(4);
    }];
    return header;
}

- (void)loadGuessYlikeView:(UIView *)contentView withGuessYlikeModel:(HEBGuessYlikeModel *)model {
    HEBGuessYlikeView *guessYlikeView = [[HEBGuessYlikeView alloc] init];
    [guessYlikeView cellforGuessYlikeModel:model];
    [contentView addSubview:guessYlikeView];
    [guessYlikeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView);
    }];
}

- (void)loadScreeningView:(HEBGuessYlikeHeaderView *)header btn:(QMUIButton *)sender {
     __weak __typeof(self)weakSelf = self;
    if (sender.tag == 100) {
        HEBSequencingView *sequencingView = [[HEBSequencingView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        sequencingView.changeCellModelArr = ^(NSArray *cellModelArr, NSInteger idx) {
            if (weakSelf.getScreeningDidClick) {
                weakSelf.getScreeningDidClick(idx);
            }
            weakSelf.sequencingCellModelArr = cellModelArr;
            weakSelf.sequencingMsg = cellModelArr[idx][@"img"];
            [sender setTitle:weakSelf.sequencingMsg forState:UIControlStateNormal];
            [weakSelf.sequencingView removeFromSuperview];
            weakSelf.sequencingView = nil;
        };
        selfClass(sequencingView);
        sequencingView.backgroundColor = UIColorWhite;
        sequencingView.cellModelArr = self.sequencingCellModelArr;
        [self.window addSubview:sequencingView];
        [sequencingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(40);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [sequencingView updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            [sequencingView layoutIfNeeded];
        }];
        
    }else {
        HEBScreeningView *screeningView = [[HEBScreeningView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        screeningView.shopCellModelArr = self.shopCellModelArr;
        screeningView.moneyCellModelArr = self.moneyCellModelArr;
        selfClass(screeningView);
        screeningView.backgroundColor = UIColorHex(#f1f1f1);
        [self.window addSubview:screeningView];
        [screeningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(40);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [screeningView updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            [screeningView layoutIfNeeded];
        }];
        screeningView.getSelectScreeningINFO = ^(NSDictionary *selectINFO, NSArray *shopCellModelArr, NSArray *moneyCellModelArr) {
            weakSelf.shopCellModelArr = shopCellModelArr;
            weakSelf.moneyCellModelArr = moneyCellModelArr;
            if (weakSelf.getSelectScreeningINFO) {
                weakSelf.getSelectScreeningINFO(selectINFO);
            }
            [weakSelf.screeningView removeFromSuperview];
            weakSelf.screeningView = nil;
        };
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section != 3) {
        return;
    }
    HEBTakOutDetailViewController *takeOut = [[HEBTakOutDetailViewController alloc] init];
    takeOut.shop_id = self.guessYlikeModelArrM[indexPath.row].objid;
    [self.viewController.navigationController pushViewController:takeOut animated:YES];
}

- (NSArray<HEBClassificationModel *> *)classificationModelArr {
    if (!_classificationModelArr) {
        _classificationModelArr = [NSArray array];
    }
    return _classificationModelArr;
}

- (NSArray<HEBHotSellModel *> *)hotSellModelArr {
    if (!_hotSellModelArr) {
        _hotSellModelArr = [NSArray array];
    }
    return _hotSellModelArr;
}

- (NSArray<HEBOptimizationModel *> *)optimizationModelArr {
    if (!_optimizationModelArr) {
        _optimizationModelArr = [NSArray array];
    }
    return _optimizationModelArr;
}

- (NSMutableArray<HEBGuessYlikeModel *> *)guessYlikeModelArrM {
    if (!_guessYlikeModelArrM) {
        _guessYlikeModelArrM = [NSMutableArray array];
    }
    return _guessYlikeModelArrM;
}

- (NSArray *)sequencingCellModelArr {
    if (!_sequencingCellModelArr) {
        _sequencingCellModelArr = @[@{@"img":@"综合排序", @"select":@"Y"},
                                    @{@"img":@"评分最高", @"select":@""},
                                    @{@"img":@"起送价最低", @"select":@""},
                                    @{@"img":@"配送费最低", @"select":@""},
                                    @{@"img":@"人均高到低", @"select":@""},
                                    @{@"img":@"人均低到高", @"select":@""}];
    }
    return _sequencingCellModelArr;
}

- (NSArray *)shopCellModelArr {
    if (!_shopCellModelArr) {
        _shopCellModelArr = @[@{@"msg":@"免费配送", @"select":@""},
                              @{@"msg":@"新商家", @"select":@""}];
    }
    return _shopCellModelArr;
}

- (NSArray *)moneyCellModelArr {
    if (!_moneyCellModelArr) {
        _moneyCellModelArr = @[@{@"msg":@"¥0-20", @"select":@""},
                              @{@"msg":@"¥20-50", @"select":@""},
                              @{@"msg":@"¥50-100", @"select":@""},
                              @{@"msg":@"¥100-200", @"select":@""},
                              @{@"msg":@"¥200-300+", @"select":@""}];
    }
    return _moneyCellModelArr;
}

@end
