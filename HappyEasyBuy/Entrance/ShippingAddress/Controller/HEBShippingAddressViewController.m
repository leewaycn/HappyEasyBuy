//
//  HEBShippingAddressViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBShippingAddressViewController.h"
#import "HEBShippingAddressView.h"
#import "HEBLocationModel.h"

@interface HEBShippingAddressViewController ()

@property(nonatomic, strong) HEBShippingAddressView *shipView;

@end

@implementation HEBShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"完成" tintColor:UIColorBlack position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    HEBShippingAddressView *shipView = [[HEBShippingAddressView alloc] init];
    selfClass(shipView);
    [self.baseView addSubview:shipView];
    [shipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    if (self.locationModel) {
        shipView.userName.text = self.locationModel.name;
        if (self.locationModel.call) {
            QMUIButton *man = [shipView viewWithTag:100];
            man.selected = NO;
            man.userInteractionEnabled = YES;
            QMUIButton *woman = [shipView viewWithTag:101];
            woman.selected = YES;
            woman.userInteractionEnabled = NO;
        }else {
            QMUIButton *man = [shipView viewWithTag:100];
            man.selected = YES;
            man.userInteractionEnabled = NO;
            QMUIButton *woman = [shipView viewWithTag:101];
            woman.selected = NO;
            woman.userInteractionEnabled = YES;
        }
        shipView.mobNumber.text = self.locationModel.mobile;
        shipView.location.text = self.locationModel.location;
        shipView.address.text = self.locationModel.address;
    }
}

- (void)rightBarButtonItemDidClick {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%d", [(QMUIButton *)[self.shipView viewWithTag:101] isSelected]] forKey:@"call"];
    [params setObject:getUser_id forKey:@"vipid"];
    NSString *alertMsg;
    if (self.shipView.userName.hasText) {
        [params setObject:self.shipView.userName.text forKey:@"name"];
        if (self.shipView.mobNumber.text.isMobNumber) {
            [params setObject:self.shipView.mobNumber.text forKey:@"mobile"];
            if (self.shipView.location.hasText) {
                [params setObject:self.shipView.location.text forKey:@"location"];
                if (self.shipView.address.hasText) {
                    [params setObject:self.shipView.address.text forKey:@"address"];
                }else {
                    alertMsg = @"请输入收货人详细地址";
                }
            }else {
                alertMsg = @"请选择收货人地址";
            }
        }else {
            alertMsg = @"请检查收货人手机号是否正确";
        }
    }else {
        alertMsg = @"请输入收货人姓名";
    }
    if (alertMsg.length) {
        [ISMessages showCardAlertWithTitle:@"操作失败" message:alertMsg duration:1.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    NSString *url;
    if (self.locationModel) {
        [params setObject:self.locationModel.locationid forKey:@"id"];
        url = UserChangeAddress;
    }else {
        url = UserSetAddress;
    }
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:url params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            if (weakSelf.locationModel) {
                [weakSelf.locationModel setName:params[@"name"]];
                [weakSelf.locationModel setMobile:params[@"mobile"]];
                [weakSelf.locationModel setAddress:params[@"address"]];
                [weakSelf.locationModel setLocation:params[@"location"]];
                [weakSelf.locationModel setCall:params[@"call"]];
                if (weakSelf.locationChange) {
                    weakSelf.locationChange(weakSelf.locationModel);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else {
                if (weakSelf.locationAddSuccess) {
                    HEBLocationModel *model = [[HEBLocationModel alloc] init];
                    [model setName:params[@"name"]];
                    [model setMobile:params[@"mobile"]];
                    [model setAddress:params[@"address"]];
                    [model setLocation:params[@"location"]];
                    [model setLocationid:mainModel.data[@"id"]];
                    [model setCall:params[@"call"]];
                    weakSelf.locationAddSuccess(model);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
        }else {
            [ISMessages showCardAlertWithTitle:@"操作失败" message:mainModel.msg duration:1.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


@end

