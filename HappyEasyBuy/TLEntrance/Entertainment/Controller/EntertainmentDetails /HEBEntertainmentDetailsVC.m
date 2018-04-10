//
//  HEBEntertainmentDetailsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBEntertainmentDetailsVC.h"
#import "HEBCycleScrollView.h"
#import "HEBLevelView.h"
#import "HEBEntertainmentDetailsTableViewCell.h"
#import "HEBCheckViewController.h" //买单暂用
#import "HEBBuyOrderViewController.h"//获取到数据替换上面暂用
#import "HEBGroupBuyDetailsVC.h"
#import "HEBEntertainmentDetailsView.h"
#import "HEBMapViewController.h"//地图VC
#import "HEBEntertainmentDetailsModel.h"
@interface HEBEntertainmentDetailsVC ()

/** 店铺名称 */
@property(nonatomic, strong) UILabel *shopName;

@property(nonatomic, strong) HEBEntertainmentDetailsView *groupPurchaseTabelView;

/** 套餐数量 */
@property(nonatomic, strong) UILabel *groupPurchaseLabel;

@property(nonatomic, weak) UILabel *locationLabel;

@property(nonatomic, strong) HEBMapViewController *mapViewController;

@property(nonatomic, strong)HEBEntertainmentDetailsModel *entertainmentDetailsModel;


@end

@implementation HEBEntertainmentDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
}


#pragma mark-setupUI
-(void)setUI {
#pragma mark-//----轮播图
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,-getNavigationHeight, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
//    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"3"];
    [self.view addSubview:cyView];

#pragma mark-//----娱乐店铺信息view
    //店铺信息
    UIView *shopView = [[UIView alloc]init];
    shopView.bottomLine = YES;
    shopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopView];
    [shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(cyView.mas_bottom);
        make.height.mas_offset(60);
        }];
    
    //店铺名称
    UILabel *shopName = [[UILabel alloc]init];
    selfClass(shopName);
    shopName.font = [UIFont systemFontOfSize:14];
    [shopView addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(shopView).mas_offset(5);
        
    } ];
    //星评View
    HEBLevelView *levelView = [[HEBLevelView alloc]init];
    [shopView addSubview:levelView];
    [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName);
        make.top.equalTo(shopName.mas_bottom).offset(2);
        make.width.mas_offset(70);
        make.height.mas_offset(14);
   }];
//    星分
    UILabel *levelLabel = [[UILabel alloc]init];
    levelLabel.text = @"5分";
    levelLabel.textColor = [UIColor blackColor];
    levelLabel.font = [UIFont systemFontOfSize:12];
    [shopView addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(levelView.mas_right).offset(2);
        make.bottom.equalTo(levelView.mas_bottom);
    }];
    
    //买单btn
    UIButton *checkBtn = [UIButton new];
    checkBtn.layer.cornerRadius =5.0;
    checkBtn.layer.masksToBounds = YES;
    checkBtn.backgroundColor = [UIColor orangeColor];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkBtn addTarget:self action:@selector(checkBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [checkBtn setTitle:@"买单" forState:UIControlStateNormal];
        [shopView addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopView.mas_centerY);
        make.right.equalTo(shopView).offset(-20);
        make.width.mas_offset(40);
    }];
   
    
#pragma mark-//----地址和电话View
    UIView *addressView = [[UIView alloc]init];
    //添加View手势
    UITapGestureRecognizer *addressViewGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapevent:)];
    [addressView addGestureRecognizer:addressViewGesture];
     [addressViewGesture setNumberOfTapsRequired:1];
    
    //    添加View底部线条
    addressView.bottomLine = YES;
    addressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(shopView.mas_bottom).offset(5);
        make.height.mas_offset(60);
    }];
    //定位imgVIew
    UIImageView *locationImageView = [[UIImageView alloc]init];
    locationImageView.image = [UIImage imageNamed:@"定位"];
    locationImageView.contentMode = UIViewContentModeScaleAspectFit;

    [addressView addSubview:locationImageView];
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView).mas_offset(10);
        make.centerY.equalTo(addressView.mas_centerY);
        make.width.height.mas_offset(20);
    }];
    //地区Label
    UILabel *locationLabel = [UILabel new];
    _locationLabel = locationLabel;
    locationLabel.text = @"测试位置兰山区";
    locationLabel.font = [UIFont systemFontOfSize:12];
    [addressView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImageView.mas_right);
        make.top.equalTo(addressView).offset(5);
    }];
//    电话按钮
    UIButton *phoneBtn = [[UIButton alloc]init];
    [phoneBtn setBackgroundImage:[UIImage imageNamed:@"联系"] forState:UIControlStateNormal];
    [phoneBtn setBackgroundImage:[UIImage imageNamed:@"联系"] forState:UIControlStateHighlighted];
    //设置图片渲染
    phoneBtn.contentMode = UIViewContentModeScaleAspectFit;
    [phoneBtn addTarget:self action:@selector(phoneBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [addressView addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addressView.mas_right).offset(-10);
        make.centerY.equalTo(addressView.mas_centerY);
        make.width.mas_offset(30);
        make.height.mas_offset(30);

    }];
    //分隔线
    UIView *linkeView = [UIView new];
    linkeView.backgroundColor = UIColorHex(#f1f1f1);
    [addressView addSubview: linkeView];
    [linkeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(phoneBtn.mas_left).offset(-10);
        make.centerY.equalTo(addressView.mas_centerY);
        make.height.mas_offset(40);
        make.width.mas_offset(1);
    }];
    
    
    
    
#pragma mark----//Coupon 优惠券View
    UIView *couponView = [[UIView alloc]init];
    couponView.bottomLine = YES;
    couponView.backgroundColor = [UIColor whiteColor];
    //添加View手势
    UITapGestureRecognizer *couponViewGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(couponViewGesture:)];
    [couponView addGestureRecognizer:couponViewGesture];
    [couponViewGesture setNumberOfTapsRequired:1];
    
    [self.view addSubview:couponView];
    [couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(addressView.mas_bottom).offset(5);
        make.height.mas_offset(45);
    }];
    //    店铺优惠券
    UIImageView *couponImageView = [UIImageView new];
    couponImageView.image = [UIImage imageNamed:@"店铺优惠券"];
    couponImageView.contentMode = UIViewContentModeScaleAspectFit;
    [couponView addSubview:couponImageView];
    [couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(couponView.mas_centerY);
        make.left.equalTo(couponView.mas_left).offset(10);
        make.height.mas_offset(20);
        make.width.mas_offset(60);
    }];
    //领取优惠券
    UILabel *couponLabel = [[UILabel alloc]init];;
    couponLabel.text = @"领取优惠券";
    couponLabel.font = [UIFont systemFontOfSize:12];
    [couponView addSubview:couponLabel];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponImageView.mas_right).offset(5);
        make.centerY.equalTo(couponImageView.mas_centerY);
    }];
    UIImageView *arrowImageView = [[UIImageView alloc]init];
    arrowImageView.image = [UIImage imageNamed:@"fanhui"];
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [couponView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(couponView).offset(-5);
        make.centerY.equalTo(couponView);
        
    }];
    
    
#pragma mark- //------ 团购View
    UIView * groupPurchaseView = [[UIView alloc]init];
    groupPurchaseView.bottomLine = YES;
    groupPurchaseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:groupPurchaseView];
    [groupPurchaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(couponView.mas_bottom).offset(5);
        make.height.mas_offset(45);
    }];
    //团购imageView
    UIImageView *groupPurchaseImageView = [UIImageView new];
    groupPurchaseImageView.image = [UIImage imageNamed:@"美食团购订单"];
    groupPurchaseImageView.contentMode = UIViewContentModeScaleAspectFit;
    [groupPurchaseView addSubview:groupPurchaseImageView];
    [groupPurchaseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(groupPurchaseView);
        make.left.equalTo(groupPurchaseView).offset(10);
        make.height.width.mas_offset(20);
    }];
    
    UILabel *groupPurchaseLabel = [UILabel new];
    selfClass(groupPurchaseLabel);
    groupPurchaseLabel.text = @"团购（0）";
    [groupPurchaseView addSubview:groupPurchaseLabel];
    [groupPurchaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(groupPurchaseImageView.mas_right).offset(10);
        make.centerY.equalTo(groupPurchaseImageView);
    }];
    
#pragma mark- 团购TbaView列表
    HEBEntertainmentDetailsView *groupPurchaseTabelView = [[HEBEntertainmentDetailsView alloc]init];
    selfClass(groupPurchaseTabelView);
    [self.view addSubview:groupPurchaseTabelView];
    [groupPurchaseTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(groupPurchaseView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    NSString *url = @"Home/Happy/foot_info";
//    ,@"lat":self.lat,@"lng":self.lng
    [Networking postUrl:url params:@{@"ha_id":self.ha_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        NSLog(@"%@",response);
        
        self.entertainmentDetailsModel = [HEBEntertainmentDetailsModel yy_modelWithJSON:mainModel.data];
        
        weakSelf.groupPurchaseTabelView.entertainmentDetailsModel = self.entertainmentDetailsModel;

//        赋值
//        weakSelf.shopName.text = self.entertainmentDetailsModel.ha_name;
//        weakSelf.locationLabel.text = mainModel.data[@"ha_address"];
//
        
        
        [Networking postUrl:LeisurePackageList params:@{@"ha_id":weakSelf.ha_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            NSLog(@"%@",response);
            [weakSelf dismissProgressHUD];
            weakSelf.groupPurchaseTabelView.cellModelArr = [NSArray yy_modelArrayWithClass:[HEBEntertainmentDetailsListModel class] json:mainModel.data];
            [weakSelf.groupPurchaseTabelView reloadData];
            weakSelf.groupPurchaseLabel.text = [NSString stringWithFormat:@"团购（%ld）", [mainModel.data count]];
        }];
    }];
    
}


#pragma maek-买单
-(void)checkBtnClik:(UIButton *)senter{
    NSLog(@"买单");
    /** 商家类型 */
//    @property(nonatomic, copy) NSString *type;
//    
//    /** 商家id */
//    @property(nonatomic, copy) NSString *shop_id;
//
//    /** 商家名称 */
//    @property(nonatomic, copy) NSString *shopName;

//   //传入商家类型，ID， 商家名称 即可跳转
//    HEBBuyOrderViewController *buyOrderViewController = [[HEBBuyOrderViewController alloc]init];
//    [self.navigationController pushViewController:buyOrderViewController animated:NO];
    
//    暂用此控制器
    HEBCheckViewController *checkViewController = [[HEBCheckViewController alloc]init];
     [self.navigationController pushViewController:checkViewController animated:YES];
    
}
#pragma maek-addressView跳转到地图导航
- (void)tapevent:(UITapGestureRecognizer *)gesture {
     NSLog(@"点击了跳转地图");
    /** 店铺纬度 */
//    @property(nonatomic, assign) double lat;
//
//    /** 店铺经度 */
//    @property(nonatomic, assign) double lon;
//
//    /** 店铺名称 */
//    @property(nonatomic, copy) NSString *shopName;
//
//    /** 地址 */
//    @property(nonatomic, copy) NSString *address;
//
//    /** 联系方式 */
//    @property(nonatomic, copy) NSString *phone;
    HEBMapViewController *mapViewController = [HEBMapViewController new];

    mapViewController.shopName = self.entertainmentDetailsModel.ha_name;
    mapViewController.lat = *(self.entertainmentDetailsModel.lat);
    mapViewController.lon = *(self.entertainmentDetailsModel.lng);
    mapViewController.address = self.entertainmentDetailsModel.ha_address;
    mapViewController.phone = self.entertainmentDetailsModel.ha_tel;
    
//    _mapViewController = mapViewController;
    
//    传参
    
    
    [self.navigationController pushViewController:mapViewController animated:YES];
}

#pragma maek-电话按钮点击事件
-(void)phoneBtnClik:(UIButton *)senter{
    
    NSLog(@"拨打电话");
}
#pragma maek-跳转到优惠券视图
-(void)couponViewGesture:(UITapGestureRecognizer *)couponViewGesture{
    
    NSLog(@"跳转到优惠券");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarTransparence];
}

@end
