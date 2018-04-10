//
//  HEBCompanyViewController.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBCompanyViewController.h"
#import "HEBCycleScrollView.h"
#import "HEBSearchViewController.h"
#import "HEBCompanyCell.h"
#import "HEBCompanyModel.h"
#import "HEBCompanyDetailsVC.h"
#import "HEBEnterpriseRecruitVC.h"
@interface HEBCompanyViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 临时存储页码 */
@property(nonatomic, assign) int page;
/** 存储请求信息 */
@property(nonatomic,strong) NSMutableDictionary *params;

/** 搜索btn */
@property(nonatomic, strong) QMUIButton *searchBtn;
/*轮播图 */
@property(nonatomic, weak) HEBCycleScrollView *cyView;
//公司/企业TableView
@property(nonatomic, weak) UITableView *companyTableView;
//企业公司列表数组
@property(nonatomic, strong)NSMutableArray <HEBCompanyModel *>*companyListArrayM;


@end
static NSString *cellID = @"cellID";
@implementation HEBCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    self.page = 1;
    [self loadData];
    [self loadSearchView];
    [self verbView];
    [self setupUI];
}
#pragma mark-loadData
-(void)loadData{

//    http://luntan.guoxiangou.cn/Home/Company/companyList
    NSString *url = @"Home/Company/companyList";
    
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    
    [Networking postUrl:url params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
       
        self.companyListArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBCompanyModel class] json:mainModel.data]];
        
        [self.companyTableView reloadData];
//        NSLog(@"%zd",self.companyListArrayM.count);
        
    }];
    
    
}

#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companyListArrayM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HEBCompanyCell *companyCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    companyCell.companyModel = self.companyListArrayM[indexPath.row];
    
    
    return companyCell;
}


#pragma mark- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HEBCompanyDetailsVC *companyDetailsVC = [[HEBCompanyDetailsVC alloc]init];
    companyDetailsVC.objid = self.companyListArrayM[indexPath.row].objid;
    [self.navigationController pushViewController:companyDetailsVC animated:YES];
}



#pragma mark-setupUI
-(void)setupUI{
    UITableView *companyTableView = [[UITableView alloc]init];
    _companyTableView = companyTableView;
    companyTableView.bottomLine = YES;
    companyTableView.dataSource = self;
    companyTableView.delegate = self;
//    companyTableView.backgroundColor = [UIColor greenColor];
    [companyTableView registerClass:[HEBCompanyCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview: companyTableView ];
    [companyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.cyView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
//    企业招聘View
    UIView *bottomView = [UIView new];
    //添加手势
    UITapGestureRecognizer * bottomViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewEvent:)];
    //将手势添加到需要相应的view中去
    [bottomView addGestureRecognizer:bottomViewGesture];
    //选择触发事件的方式（默认单机触发）
    [bottomViewGesture setNumberOfTapsRequired:1];
    
    
    [self.view addSubview: bottomView ];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(40);
    }];
    
    UIImageView *bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    [bottomView addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(10);
        make.centerY.equalTo(bottomView);
        make.width.height.mas_offset(20);
    }];
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.text = @"企业招聘";
//    bottomLabel.textColor = [UIColor orangeColor];
    bottomLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomImageView.mas_right).offset(5);
        make.centerY.equalTo(bottomView);
    }];
}







#pragma mark 执行触发的方法

- (void)bottomViewEvent:(UITapGestureRecognizer *)bottomViewGesture{

    NSLog(@"点击企业View");
    HEBEnterpriseRecruitVC *enterpriseRecruitVC = [[HEBEnterpriseRecruitVC alloc]init];
 
    [self.navigationController pushViewController:enterpriseRecruitVC animated:YES];
}


#pragma mark//添加轮播图
- (void)verbView
{
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 140*SCREEN_WIDTH/375)];
    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"7"];
    [self.view addSubview:cyView];
}


#pragma mark//添加导航栏搜索
- (void)loadSearchView {
    QMUIButton *searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(50, (getNavigationHeight-28)/2-(IS_58INCH_SCREEN?22:10), SCREEN_WIDTH-90, 28)];
    selfClass(searchBtn);
    searchBtn.layer.cornerRadius = 12;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderWidth = 1.f;
    searchBtn.layer.borderColor = UIColorMakeWithRGBA(210, 194, 194, 0.8).CGColor;
    searchBtn.backgroundColor = UIColorMakeWithRGBA(252, 249, 244, 0.8);
    [self.navigationController.navigationBar addSubview:searchBtn];
    
    UIImageView *searchimg = [[UIImageView alloc] initWithImage:UIImageMake(@"搜索")];
    [searchBtn addSubview:searchimg];
    [searchimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBtn.mas_left).offset(15);
        make.top.equalTo(searchBtn.mas_top).offset(5);
        make.bottom.equalTo(searchBtn.mas_bottom).offset(-5);
        make.width.mas_offset(20);
    }];
    
    UIView *margin = [[UIView alloc] init];
    margin.backgroundColor = UIColorGray;
    [searchBtn addSubview:margin];
    [margin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchimg.mas_right).offset(9);
        make.top.bottom.equalTo(searchimg);
        make.width.mas_offset(1);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"请输入商家或商品名称";
    msg.textColor = UIColorGray;
    msg.font = UIFontMake(14);
    [searchBtn addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn.mas_centerY);
        make.left.equalTo(margin.mas_right).offset(8);
        make.right.equalTo(searchBtn.mas_right);
    }];
    
    __weak __typeof(self)weakSelf = self;
    [searchBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        HEBSearchViewController *search = [[HEBSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:search animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBtn setHidden:NO];
    if (IS_58INCH_SCREEN) {
        self.navigationController.navigationBar.barTintColor = BASECOLOR;
        self.navigationController.navigationBar.tintColor = UIColorWhite;
    }else {
        [self setNavigationBarTransparence];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    [self.searchBtn setHidden:YES];
}

//列表参数
- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}


@end
