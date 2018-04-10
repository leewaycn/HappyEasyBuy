//
//  HEBOrderListViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderListViewController.h"
#import "HEBOrderListHeaderToolsView.h"
#import "HEBOrderListView.h"

@interface HEBOrderListViewController ()

/** 顶部工具视图 */
@property(nonatomic, strong) HEBOrderListHeaderToolsView *headerToolsView;

/** 请求参数 */
@property(nonatomic, strong) NSMutableDictionary *params;

/** 记录页码 */
@property(nonatomic, assign) int page;

@property(nonatomic, strong) HEBOrderListView *orderlist;

/** 积分订单请求地址 */
@property(nonatomic, strong) NSString *url;

@end

@implementation HEBOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    self.page = 1;
    HEBOrderListHeaderToolsView *headerToolsView = [[HEBOrderListHeaderToolsView alloc] init];
    selfClass(headerToolsView);
    [self.baseView addSubview:headerToolsView];
    [headerToolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    __weak __typeof(self)weakSelf = self;
    if (self.type.intValue != 2 || self.type.intValue == 6) {
        if (self.type.intValue != 6) {
            headerToolsView.toolsArr = @[@"全部", @"待付款", @"待确定", @"待评价"];
        }else {
            headerToolsView.toolsArr = @[@"优惠券", @"商品"];
            self.url = [NSString stringWithFormat:@"%@virtual", IntegralOrderList];
        }
    }else {
        headerToolsView.toolsArr = @[@"全部", @"待付款", @"待确定"];
    }
    [headerToolsView loadToolsView];
    headerToolsView.getHeaderToolsDidCick = ^(NSString *toolName, NSInteger tag) {
        NSString *status = @"";
        switch (tag) {
            case 0:
                status = @"12";
                weakSelf.url = [NSString stringWithFormat:@"%@virtual", IntegralOrderList];
                weakSelf.orderlist.isVirtual = YES;
                break;
            case 1:
                status = @"1";
                weakSelf.url = [NSString stringWithFormat:@"%@kind", IntegralOrderList];
                weakSelf.orderlist.isVirtual = NO;
                break;
            case 2:
                status = @"9";
                break;
            case 3:
                status = @"5";
            default:
                break;
        }
        [weakSelf.params setObject:status forKey:@"status"];
        [weakSelf.orderlist.mj_header beginRefreshing];
    };
    
    HEBOrderListView *orderlist = [[HEBOrderListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    orderlist.isVirtual = YES;
    selfClass(orderlist);
    [self.baseView addSubview:orderlist];
    [orderlist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerToolsView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    orderlist.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    orderlist.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    orderlist.mj_header.automaticallyChangeAlpha = YES;
    orderlist.mj_footer.automaticallyHidden = YES;
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:(self.type.intValue==6?self.url:OrderList) params:(self.type.intValue==6?@{@"user_id":getUser_id, @"page":[NSString stringWithFormat:@"%d", self.page], @"size":[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT]}:self.params) callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [weakSelf.orderlist.mj_header endRefreshing];
        [weakSelf.orderlist.mj_footer endRefreshing];
        
        if (weakSelf.page != 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
            weakSelf.page++;
            [weakSelf.orderlist.orderlistArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBOrderListModel class] json:mainModel.data]];
            [weakSelf.orderlist.mj_footer resetNoMoreData];
        }
        if (weakSelf.page == 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
            [weakSelf.orderlist.orderlistArrM removeAllObjects];
            weakSelf.page++;
            [weakSelf.orderlist.orderlistArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBOrderListModel class] json:mainModel.data]];
            [weakSelf.orderlist.mj_footer resetNoMoreData];
        }
        if (weakSelf.page == 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
            [weakSelf.orderlist.orderlistArrM removeAllObjects];
            [weakSelf.orderlist.orderlistArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBOrderListModel class] json:mainModel.data]];
            [weakSelf.orderlist.mj_footer endRefreshingWithNoMoreData];
        }
        if (weakSelf.page != 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
            [weakSelf.orderlist.orderlistArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBOrderListModel class] json:mainModel.data]];
            [weakSelf.orderlist.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.orderlist reloadData];
    }];
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:self.type forKey:@"type"];
        [_params setObject:getUser_id forKey:@"vipid"];
        [_params setObject:@"12" forKey:@"status"];
        [_params setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
    }
    return _params;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
