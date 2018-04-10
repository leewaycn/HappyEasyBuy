//
//  HEBTakeoutSearchViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBTakeoutSearchViewController.h"
#import "HEBTakeoutSearchView.h"

@interface HEBTakeoutSearchViewController ()<QMUITextFieldDelegate>

/** 搜索按钮 */
@property(nonatomic, strong) QMUITextField *searchField;

@property(nonatomic, strong) HEBTakeoutSearchView *searchView;

@end

@implementation HEBTakeoutSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUI {
    [self loadSearchBtn];
    [self loadSearchView];
}

- (void)loadSearchBtn {
    QMUITextField *searchField = [[QMUITextField alloc] initWithFrame:CGRectMake(50, (getNavigationHeight-28)/2-(IS_58INCH_SCREEN?22:10), SCREEN_WIDTH-90, 28)];
    selfClass(searchField);
    searchField.delegate = self;
    searchField.layer.cornerRadius = 12;
    searchField.layer.masksToBounds = YES;
    searchField.layer.borderWidth = 1.f;
    searchField.layer.borderColor = UIColorMakeWithRGBA(210, 194, 194, 0.8).CGColor;
    searchField.backgroundColor = UIColorMakeWithRGBA(252, 249, 244, 0.8);
    [self.navigationController.navigationBar addSubview:searchField];
    [searchField becomeFirstResponder];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.size = CGSizeMake(20, 20);
    searchField.placeholder = @"请输入商家或商品名称";
    searchField.leftView = leftView;
    searchField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchimg = [[UIImageView alloc] initWithImage:UIImageMake(@"搜索")];
    [leftView addSubview:searchimg];
    [searchimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(leftView);
        make.left.equalTo(leftView.mas_left).offset(5);
        make.width.mas_offset(20);
    }];
    
    QMUIButton *search = [[QMUIButton alloc] init];
    [search setTitle:@"搜索" forState:UIControlStateNormal];
    [search setTitleColor:UIColorGray forState:UIControlStateNormal];
    search.size = CGSizeMake(40, 20);
    search.titleLabel.font = UIFontMake(14);
    searchField.rightView = search;
    searchField.rightViewMode = UITextFieldViewModeAlways;
    
    [search addTarget:self action:@selector(searchDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadSearchView {
    HEBTakeoutSearchView *searchView = [[HEBTakeoutSearchView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(searchView);
    [self.baseView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)searchDidClick {
    [self.searchField resignFirstResponder];
    if (!self.searchField.hasText) {
        [ISMessages showCardAlertWithTitle:@"搜索失败" message:@"您并未输入任何搜索内容" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:TakeoutSearch params:@{@"city_id":getCity_id, @"keyword":self.searchField.text.removeSpace} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        weakSelf.searchView.searchModelArr = [NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data];
        [weakSelf.searchView reloadData];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchDidClick];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchField setHidden:NO];
    if (IS_58INCH_SCREEN) {
        self.navigationController.navigationBar.barTintColor = BASECOLOR;
        self.navigationController.navigationBar.tintColor = UIColorWhite;
    }else {
        [self setNavigationBarTransparence];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchField setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (!self.navigationController.viewControllers.count) {
        [self.searchField removeFromSuperview];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


@end
