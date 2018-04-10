//
//  HEBBillViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBillViewController.h"
#import "HEBBillView.h"

@interface HEBBillViewController ()

@property(nonatomic, strong) NSMutableDictionary *params;

@property(nonatomic, assign) int page;

@end

@implementation HEBBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"时间" tintColor:BASECOLOR position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    HEBBillView *billView = [[HEBBillView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.baseView addSubview:billView];
    [billView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:@"Home/Mingxi/mingxilist" params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        NSLog(@"%@", response);
    }];
}

- (void)rightBarButtonItemDidClick {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:getUser_id forKey:@"u_id"];
        [_params setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_params setObject:@"4" forKey:@"status"];
    }
    return _params;
}

@end
