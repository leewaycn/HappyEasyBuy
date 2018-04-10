//
//  HEBGastronomyView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGastronomyView.h"
#import "HEBCycleScrollView.h"
#import "HEBGastronomyHeaderToolsView.h"
#import "HEBGastronomyListViewController.h"
#import "HEBShopDetailsViewController.h"

@interface HEBGastronomyView ()<QMUITableViewDelegate, QMUITableViewDataSource, UIScrollViewDelegate>

/** 顶部筛选视图 */
@property(nonatomic, strong) HEBGastronomyHeaderToolsView *headerToolsView;

@end

@implementation HEBGastronomyView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBCycleScrollView *cycleScroller = [[HEBCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    [cycleScroller startLocationCycleScrollViewType:@"6"];
    self.tableHeaderView = cycleScroller;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==2?self.foodStoresModelArrM.count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0?(self.classificationModelArr.count?200:0):
            indexPath.section==1?(self.optimizationModelArr.count?120:0):
            indexPath.section==2&&self.foodStoresModelArrM.count?80:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==2?44:CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==2) {
        __weak __typeof(self)weakSelf = self;
        HEBGastronomyHeaderToolsView *headerToolsView = [[HEBGastronomyHeaderToolsView alloc] init];
        if (self.localName.length) {
            [headerToolsView.btnArrM.lastObject setTitle:self.localName forState:UIControlStateNormal];
        }
        if (self.networkingName.length) {
            [headerToolsView.btnArrM.firstObject setTitle:self.networkingName forState:UIControlStateNormal];
        }
        selfClass(headerToolsView);
        headerToolsView.getHeaderToolsDidClick = ^(NSInteger idx) {
            if (![self canBeLoad]) {
                return ;
            }
            if (idx == 101) {
                [weakSelf.networkingScreeningView removeFromSuperview];
                weakSelf.networkingScreeningView = nil;
                if (weakSelf.localScreeningView) {
                    [weakSelf.localScreeningView removeFromSuperview];
                    weakSelf.localScreeningView = nil;
                    return ;
                }
                [weakSelf loadLocalScreeningView];
            }else {
                [weakSelf.localScreeningView removeFromSuperview];
                weakSelf.localScreeningView = nil;
                if (weakSelf.networkingScreeningView) {
                    [weakSelf.networkingScreeningView removeFromSuperview];
                    weakSelf.networkingScreeningView = nil;
                    return;
                }
                [weakSelf loadNetworkingScreeningView];
            }
        };
        return headerToolsView;
    }
    return [UIView new];
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
    if (indexPath.section == 0) {
        __weak __typeof(self)weakSelf = self;
        ClassificationsView *classificationsView = [[ClassificationsView alloc] init];
        [classificationsView setClassificationsViewDataArr:self.classificationModelArr maxRowCount:5 maxRow:2 didClickClassifications:^(HEBClassificationModel *model) {
            HEBGastronomyListViewController *list = [[HEBGastronomyListViewController alloc] init];
            list.objid = model.objid;
            list.title = model.name;
            [weakSelf.viewController.navigationController pushViewController:list animated:YES];
        }];
        [cell.contentView addSubview:classificationsView];
        [classificationsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    if (indexPath.section == 1) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.minimumLineSpacing = 12;
        layout.itemSize = CGSizeMake(135, 90);
        HEBOptimizationView *optimizationView = [[HEBOptimizationView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        optimizationView.optimizationModelArr = self.optimizationModelArr;
        optimizationView.showsHorizontalScrollIndicator = NO;
        optimizationView.showsVerticalScrollIndicator = NO;
        [cell.contentView addSubview:optimizationView];
        [optimizationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    cell.selectionStyle = indexPath.section==2?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
    if (indexPath.section == 2) {
        cell.dividingLine = YES;
        HEBFoodStoresView *foodStoresView = [[HEBFoodStoresView alloc] init];
        [foodStoresView setCellWithModel:self.foodStoresModelArrM[indexPath.row]];
        [cell.contentView addSubview:foodStoresView];
        [foodStoresView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section != 2) {
        return;
    }
    HEBShopDetailsViewController *shop = [[HEBShopDetailsViewController alloc] init];
    shop.shop_id = self.foodStoresModelArrM[indexPath.row].shopid;
    [self.viewController.navigationController pushViewController:shop animated:YES];
}

- (void)loadNetworkingScreeningView {
    __weak __typeof(self)weakSelf = self;
    HEBFilteringRulesView *networkingScreeningView = [[HEBFilteringRulesView alloc] init];
    selfClass(networkingScreeningView);
    networkingScreeningView.tag = 100;
    networkingScreeningView.netWorkingModelArr = self.screeningModelArr;
    [self.window addSubview:networkingScreeningView];
    [networkingScreeningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.headerToolsView.bottom-self.contentOffset.y);
        make.left.right.bottom.equalTo(self);
    }];
    networkingScreeningView.getHeaderToolsDidClick = ^(NSArray *dataArr, NSInteger idx, NSString *name) {
        weakSelf.networkingName = name;
        weakSelf.screeningModelArr = dataArr;
        if (weakSelf.getNetworkingScreeningDidClick) {
            weakSelf.getNetworkingScreeningDidClick([NSString stringWithFormat:@"%ld", idx]);
        }
        [weakSelf.networkingScreeningView removeFromSuperview];
        weakSelf.networkingScreeningView = nil;
    };
    
    [networkingScreeningView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [networkingScreeningView layoutIfNeeded];
    }];
}

- (void)loadLocalScreeningView {
    __weak __typeof(self)weakSelf = self;
    HEBFilteringRulesView *localScreeningView = [[HEBFilteringRulesView alloc] init];
    selfClass(localScreeningView);
    localScreeningView.tag = 101;
    localScreeningView.localModelArr = self.loaclModelArr;
    [self.window addSubview:localScreeningView];
    [localScreeningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.headerToolsView.bottom-self.contentOffset.y);
        make.left.right.bottom.equalTo(self);
    }];
    localScreeningView.getHeaderToolsDidClick = ^(NSArray *dataArr, NSInteger idx, NSString *name) {
        weakSelf.localName = name;
        weakSelf.loaclModelArr = dataArr;
        if (weakSelf.getLoaclScreeningDidClick) {
            weakSelf.getLoaclScreeningDidClick([NSString stringWithFormat:@"%ld", idx]);
        }
        [weakSelf.localScreeningView removeFromSuperview];
        weakSelf.localScreeningView = nil;
    };
    [localScreeningView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [localScreeningView layoutIfNeeded];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![self canBeLoad]) {
        [self.localScreeningView  removeFromSuperview];
        self.localScreeningView = nil;
        [self.networkingScreeningView removeFromSuperview];
        self.networkingScreeningView = nil;
    }else if (self.localScreeningView){
        [self.localScreeningView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(self.headerToolsView.bottom-scrollView.contentOffset.y);
            make.left.right.bottom.equalTo(self);
        }];
    }else if (self.networkingScreeningView) {
        [self.networkingScreeningView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(self.headerToolsView.bottom-scrollView.contentOffset.y);
            make.left.right.bottom.equalTo(self);
        }];
    }
}

- (NSArray<HEBOptimizationModel *> *)optimizationModelArr {
    if (!_optimizationModelArr) {
        _optimizationModelArr = [NSArray array];
    }
    return _optimizationModelArr;
}

- (NSArray<HEBClassificationModel *> *)classificationModelArr {
    if (!_classificationModelArr) {
        _classificationModelArr = [NSArray array];
    }
    return _classificationModelArr;
}

- (NSMutableArray<HEBFoodStoresModel *> *)foodStoresModelArrM {
    if (!_foodStoresModelArrM) {
        _foodStoresModelArrM = [NSMutableArray array];
    }
    return _foodStoresModelArrM;
}

- (NSArray *)screeningModelArr {
    if (!_screeningModelArr) {
        _screeningModelArr = [NSArray array];
    }
    return _screeningModelArr;
}

- (NSArray *)loaclModelArr {
    if (!_loaclModelArr) {
        _loaclModelArr = @[@{@"name":@"距离最近", @"select":@"Y"},
                           @{@"name":@"价格最低", @"select":@""},
                           @{@"name":@"好评优先", @"select":@""}];
    }
    return _loaclModelArr;
}

- (BOOL)canBeLoad {
    if (self.contentOffset.y < (IOS_VERSION<11||IS_58INCH_SCREEN?0:~(getNavigationHeight + 1)) ||
        (self.headerToolsView.bottom-self.contentOffset.y-self.headerToolsView.height-(IOS_VERSION<11||IS_58INCH_SCREEN?0:getNavigationHeight))<getNavigationHeight) {
        return NO;
    }
    return YES;
}

@end
