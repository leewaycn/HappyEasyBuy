//
//  HEBGoodDetailViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallGoodsDetailViewController.h"
#import "HEIntegratedMallOrderViewController.h"
#import "HEBIntegratedMallGoodsDetailView.h"
#import "HEIntegratedMallOrderViewController.h"

@interface HEBIntegratedMallGoodsDetailViewController ()

/** 立即兑换 */
@property(nonatomic, strong) QMUIButton *exchange;

/** 库存 */
@property(nonatomic, strong) QMUILabel *stock;

/** 积分 */
@property(nonatomic, strong) YYLabel *integral;

@property(nonatomic, strong) HEBIntegratedMallGoodsDetailView *detailView;

/** 暂存数据模型 */
@property(nonatomic, strong) HEBIntegratedMallGoodsDetailModel *detailModel;

@end

@implementation HEBIntegratedMallGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
}

- (void)setUI {
    HEBIntegratedMallGoodsDetailView *detailView = [[HEBIntegratedMallGoodsDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(detailView);
    [self.baseView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo([self payINFOView].mas_top);
    }];
    
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:IntegralGoodsDetails params:@{@"id":self.objid, @"model":self.model} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
             weakSelf.detailModel = [HEBIntegratedMallGoodsDetailModel yy_modelWithJSON:[mainModel.data firstObject]];
            weakSelf.detailView.model = weakSelf.detailModel;
            if (!weakSelf.detailModel.content) {
                [weakSelf dismissProgressHUD];
            }
            [weakSelf.detailView reloadData];
            [weakSelf.detailView.headerView.icon yy_setImageWithURL:[NSURL URLWithString:weakSelf.detailModel.goods_pic] options:YYWebImageOptionProgressive];
            weakSelf.detailView.headerView.name.text = [NSString stringWithFormat:@"    %@", weakSelf.detailModel.name];
            weakSelf.integral.text = [NSString stringWithFormat:@"integral %@ 积分", weakSelf.detailModel.integral];
            if (weakSelf.detailModel.model) {
                weakSelf.stock.attributedText = [Tools toolsEditColorString:[NSString stringWithFormat:@"库存%@件", weakSelf.detailModel.quantity] searchString:weakSelf.detailModel.quantity firstColor:BASEBLACK secondColor:BASECOLOR];
            }else {
                [weakSelf.stock removeFromSuperview];
                weakSelf.stock = nil;
                [weakSelf.integral mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(weakSelf.exchange.mas_centerY);
                    make.left.equalTo(self.view.mas_left).offset(15);
                }];
            }
        }else {
            [weakSelf dismissProgressHUD];
        }
    }];
}

- (UIView *)payINFOView {
    UIView *paybgView = [[UIView alloc] init];
    paybgView.backgroundColor = UIColorWhite;
    [self.baseView addSubview:paybgView];
    [paybgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    QMUILabel *stock = [[QMUILabel alloc] init];
    selfClass(stock);
    stock.textColor = BASEBLACK;
    stock.font = UIFontMake(16);
    [paybgView addSubview:stock];
    [stock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paybgView.mas_centerY);
        make.left.equalTo(paybgView.mas_left).offset(15);
    }];
    
    YYTextSimpleEmoticonParser *integralParser = [[YYTextSimpleEmoticonParser alloc] init];
    integralParser.emoticonMapper = @{@"integral":UIImageMake(@"积分商城_积分")};
    YYLabel *integral = [[YYLabel alloc] init];
    selfClass(integral);
    integral.font = UIFontMake(14);
    integral.textColor = BASECOLOR;
    integral.textParser = integralParser;
    [paybgView addSubview:integral];
    [integral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paybgView.mas_centerY);
        make.left.equalTo(stock.mas_right).offset(15);
    }];
    
    QMUIButton *exchange = [[QMUIButton alloc] init];
    selfClass(exchange);
    exchange.backgroundColor = BASECOLOR;
    [exchange setTitle:@"立即兑换" forState:UIControlStateNormal];
    [exchange setTitleColor:UIColorWhite forState:UIControlStateNormal];
    exchange.titleLabel.font = UIFontMake(16);
    [paybgView addSubview:exchange];
    [exchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paybgView.mas_centerY);
        make.right.equalTo(paybgView.mas_right).offset(-15);
        make.width.mas_offset(100);
        make.height.equalTo(paybgView.mas_height).offset(-10);
    }];
    exchange.layer.cornerRadius = 5;
    exchange.layer.masksToBounds = YES;
    [exchange addTarget:self action:@selector(exchangeDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    return paybgView;
}

- (void)exchangeDidClick {
    __weak __typeof(self)weakSelf = self;
    if (getUser_id) {
        [self.progressHUD showAnimated:YES];
        [Networking postUrl:Myintegral params:@{@"user_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            [weakSelf dismissProgressHUD];
            if (mainModel.status) {
                if ([mainModel.data[@"integral"] integerValue] >= weakSelf.detailModel.integral.integerValue) {
                    HEIntegratedMallOrderViewController *order = [[HEIntegratedMallOrderViewController alloc] init];
                    order.imgUrl = weakSelf.detailModel.goods_pic;
                    order.name = weakSelf.detailModel.name;
                    order.count = @"1";
                    order.integral = weakSelf.detailModel.integral;
                    order.isReal = weakSelf.model.intValue;
                    order.goods_id = weakSelf.detailModel.goods_id;
                    [weakSelf.navigationController pushViewController:order animated:YES];
                }else {
                    [ISMessages showCardAlertWithTitle:@"暂时无法兑换" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
                }
            }
        }];
    }else {
        ISAlertNotLoginMessage;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
