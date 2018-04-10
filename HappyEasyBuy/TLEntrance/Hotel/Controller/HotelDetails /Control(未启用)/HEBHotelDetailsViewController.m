
//
//  HEBHotelDetailsViewController.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelDetailsViewController.h"
#import "HEBCycleScrollView.h"
@interface HEBHotelDetailsViewController ()<UITableViewDelegate>
/*酒店详情视图 */
@property(nonatomic,weak) UITableView *HotelDetailsTableView;
/*轮播图 */
@property(nonatomic,weak) HEBCycleScrollView *cyView;

//表头容器视图
@property(nonatomic,weak) UIView *HeaderView;

@end

@implementation HEBHotelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self setupUI];
    [self addHotelDetailsTableHeaderView];
    [self verbView];
    [self addlocationView];
}

-(void)setupUI{
    //创建Tabview
    UITableView *HotelDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _HotelDetailsTableView = HotelDetailsTableView;
    [self.view addSubview:HotelDetailsTableView];
//    HotelDetailsTableView.frame = self.view.bounds;
    
}

#pragma mark- //tableHeaderView 添加酒店详情表头视图
-(void)addHotelDetailsTableHeaderView{
    
    //表头容器视图
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    _HeaderView = HeaderView;
    HeaderView.backgroundColor = UIColorHex(#f1f1f1);
    HeaderView.width = self.HotelDetailsTableView.width;
    HeaderView.height = 200;
    
    self.HotelDetailsTableView.tableHeaderView = HeaderView;
}

#pragma mark- //添加轮播图
- (void)verbView{
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    _cyView = cyView;
    //    self.HotelDetailsTableView.tableHeaderView = _cyView;
    [cyView startLocationCycleScrollViewType:@"4"];
    [_HeaderView addSubview:cyView];
}

#pragma mark- //添加位置View
-(void)addlocationView{
    
    UIView *locationView = [UIView new];
    locationView.backgroundColor = [UIColor yellowColor];
    [_HeaderView addSubview:locationView];
    [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_HeaderView);
        make.top.equalTo(_cyView.mas_bottom);
        make.height.mas_offset(60);
    }];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarTransparence];
    self.navigationController.navigationBar.tintColor = UIColorWhite;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}



@end
