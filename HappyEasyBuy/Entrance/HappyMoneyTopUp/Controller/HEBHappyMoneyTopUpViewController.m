//
//  HEBHappyMoneyTopUpViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyTopUpViewController.h"
#import "HEBHappyMoneyTopUpView.h"

@interface HEBHappyMoneyTopUpViewController ()

@property(nonatomic, strong) HEBHappyMoneyTopUpView *topupView;

@end

@implementation HEBHappyMoneyTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"乐享币充值";
}

- (void)setUI {
    QMUILabel *lab = [[QMUILabel alloc] init];
    lab.dividingLine = YES;
    lab.text = @"  选择充值套餐";
    lab.font = UIFontMake(14);
    lab.textColor = UIColorGray;
    [self.baseView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.baseView.mas_top);
        make.height.mas_offset(30);
    }];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3/2);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    HEBHappyMoneyTopUpView *topupView = [[HEBHappyMoneyTopUpView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    selfClass(topupView);
    [self.baseView addSubview:topupView];
    [topupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    topupView.getHappyMoney = ^(NSString *moeny) {
        if (self.getHappyMoney) {
            self.getHappyMoney(moeny);
            [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSClassFromString(@"HEBHappyMoneyViewController") class]]) {
                    [self.navigationController popToViewController:obj animated:YES];
                }
            }];
        }
    };
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:GetConsume params:nil callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.topupView.modelArr = [NSArray yy_modelArrayWithClass:[HEBHappyMoneyTopUpModel class] json:mainModel.data];
            [weakSelf.topupView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
