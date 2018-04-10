//
//  HEBIntegratedMallViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallViewController.h"
#import "SIntergralCollectionViewCell.h"
#import "HEBSCollectHeaderView.h"
#import "HEBIntegratedMallGoodsDetailViewController.h"
#import "HEBCycleScrollView.h"
#import "HEBIntegratedMallModel.h"

static NSString *const kReuseId = @"SIntergralCollectionViewCell";
static NSString *const kHeaderReuseId = @"HEBSCollectHeaderView";

@interface HEBIntegratedMallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) HEBCycleScrollView *cyView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** 存储请求页码 */
@property(nonatomic, assign) int page;

/** 积分商城商品数据源 */
@property(nonatomic, strong) NSMutableArray<HEBIntegratedMallModel *> *cellModelArrM;

/** 请求地址 */
@property(nonatomic, copy) NSString *url;

/** 请求参数 */
@property(nonatomic, strong) NSMutableDictionary *parmas;

@end

@implementation HEBIntegratedMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    self.url = IntegralGoodsList;
    self.page = 1;
    [self loadIntegrateMallView];
    [self loadNetworking];
}

- (void)loadIntegrateMallView {
    __weak __typeof(self)weakSelf = self;
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2-5, (SCREEN_WIDTH/2-5)-16+34);
    self.flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 160*SCREEN_WIDTH/375+45);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout ];
    self.collectionView.backgroundColor = UIColorHex(#f1f1f1);
    [self.collectionView registerNib:[UINib nibWithNibName:kReuseId bundle:nil] forCellWithReuseIdentifier:kReuseId];
    [self.collectionView registerNib:[UINib nibWithNibName:kHeaderReuseId bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseId];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.baseView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-(IOS_VERSION<11?0:StatusBarHeight));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-getTabBarHeight);
    }];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    self.collectionView.mj_footer.automaticallyHidden = YES;
}

- (void)loadNetworking {
    [self.parmas setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"page"];
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:self.url params:self.parmas callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            NSMutableArray *arrM = [NSMutableArray array];
            if ([mainModel.data[@"shi"] count]) {
                [arrM addObjectsFromArray:mainModel.data[@"shi"]];
            }
            if ([mainModel.data[@"xu"] count]) {
                [arrM addObjectsFromArray:mainModel.data[@"xu"]];
            }
            if (weakSelf.page != 1 && arrM.count >= PAGE_SIZE_COUNT) {
                weakSelf.page++;
                [weakSelf.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBIntegratedMallModel class] json:arrM]];
                [weakSelf.collectionView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && arrM.count >= PAGE_SIZE_COUNT) {
                [weakSelf.cellModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBIntegratedMallModel class] json:arrM]];
                [weakSelf.collectionView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && arrM.count < PAGE_SIZE_COUNT) {
                [weakSelf.cellModelArrM removeAllObjects];
                [weakSelf.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBIntegratedMallModel class] json:arrM]];
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            if (weakSelf.page != 1 && arrM.count < PAGE_SIZE_COUNT) {
                [weakSelf.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBIntegratedMallModel class] json:arrM]];
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else {
            weakSelf.cellModelArrM = nil;
        }
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellModelArrM.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SIntergralCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseId forIndexPath:indexPath];
    HEBIntegratedMallModel *model = self.cellModelArrM[indexPath.row];
    [cell.goodImgV yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
    cell.titleLbl.text = model.title;
    cell.priceLbl.text = [NSString stringWithFormat:@"积分%@", model.integral];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
    if (kind == UICollectionElementKindSectionFooter) {
        return nil;
    }
    HEBSCollectHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderReuseId forIndexPath:indexPath];
    if (!self.collectionView.mj_header.isRefreshing) {
        __weak __typeof(self)weakSelf = self;
        [headerView.searchTF addBlockForControlEvents:UIControlEventEditingDidEnd block:^(id  _Nonnull sender) {
            UITextField *field = sender;
            if (field.hasText) {
                weakSelf.url = IntegralSearch;
                [weakSelf.parmas setObject:field.text forKey:@"keyword"];
                [weakSelf.collectionView.mj_header beginRefreshing];
            }
        }];
        [headerView.searchTF addBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            UITextField *field = sender;
            if (!field.hasText) {
                weakSelf.url = IntegralGoodsList;
                [weakSelf.parmas removeAllObjects];
                weakSelf.parmas = nil;
                [weakSelf.collectionView.mj_header beginRefreshing];
            }
        }];
    }
    if (self.cyView) {
        [headerView addSubview:self.cyView];
        return headerView;
    }
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 160*SCREEN_WIDTH/375)];
    selfClass(cyView);
    [cyView startLocationCycleScrollViewType:@"3"];
    [headerView addSubview:cyView];
    return headerView;
}

- (void)collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HEBIntegratedMallModel *model = self.cellModelArrM[indexPath.row];
    HEBIntegratedMallGoodsDetailViewController *detail = [[HEBIntegratedMallGoodsDetailViewController alloc]init];
    detail.objid = model.objid;
    detail.model = [NSString stringWithFormat:@"%d", model.model];
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableDictionary *)parmas {
    if (!_parmas) {
        _parmas = [NSMutableDictionary dictionary];
        [_parmas setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"psize"];
        [_parmas setObject:getCity_id forKey:@"city_id"];
    }
    return _parmas;
}

- (NSMutableArray<HEBIntegratedMallModel *> *)cellModelArrM {
    if (!_cellModelArrM) {
        _cellModelArrM = [NSMutableArray array];
    }
    return _cellModelArrM;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
