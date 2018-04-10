//
//  HEBHotelViewController.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelViewController.h"
#import "HEBCycleScrollView.h"
#import "HEBSearchViewController.h"
#import "HEBsorteTableViewCell.h"
#import "HEBHotelTableViewCell.h"
//#import "HEBHotelDetailsViewController.h"
#import "HEBHotelDetailViewController.h"
#import "HEBHoteListlModel.h"
#import "HEBBaseViewController.h"
@interface HEBHotelViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 搜索btn */
@property(nonatomic, strong) QMUIButton *searchBtn;


/*轮播图 */
@property(nonatomic,weak) HEBCycleScrollView *cyView;
/** 价格视图 */
@property (nonatomic,weak)UIView *priceView;
/** 智能筛选视图 */
@property (nonatomic,weak)UITableView *sorteTableView;
/** 按钮容器视图 */
@property (nonatomic,weak)UIView *btnContainer;
//** 酒店列表tablview */
@property (nonatomic,strong)UITableView *hotelTableView;
// * 酒店列表cell */
@property (nonatomic,weak) HEBHotelTableViewCell *hotelCell;
//* 排序按钮 */
@property (nonatomic,weak)UIButton *sorteBtn;
/** 临时存储页码 */
@property(nonatomic, assign) int page;
/** 存储请求信息 */
@property(nonatomic,strong) NSMutableDictionary *params;

///** 最低价 */
@property(nonatomic,weak) UITextField *minFild;
/** 最高价 */
@property(nonatomic,weak) UITextField *maxFild;
//模型
@property(nonatomic, strong) HEBHoteListlModel *hoteListlModel;
//模型数组
@property(nonatomic, strong) NSMutableArray<HEBHoteListlModel *> *hoteListArrayM;

@end

static NSString *sorteCellID = @"sorteCellID";
static NSString *hotelCell = @"hotelCell";

@implementation HEBHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self loadSearchView];
    [self verbView];
    [self loadChoiceView];
    [self setupUI];
    [self loadData];
}

-(void)setupUI{
    
    UITableView *hotelTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.hotelTableView = hotelTableView;
    hotelTableView.tag = 1;
    //注册cell
    [hotelTableView registerClass:[HEBHotelTableViewCell class] forCellReuseIdentifier:hotelCell];
    
    hotelTableView.rowHeight =60;
    hotelTableView.delegate = self;
    hotelTableView.dataSource = self;
    [self.view addSubview:hotelTableView];
    [hotelTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_btnContainer.mas_bottom).offset(1);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(void)loadData {
    NSString *url = @"Home/Room/hotel_list";
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    //    [self.params setObject:@"1" forKey:@"status"];
    [Networking postUrl:url params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        self.hoteListArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBHoteListlModel class] json:mainModel.data]];
        [self.hotelTableView reloadData];
    }];
    
}

//添加价格+排序按钮的容器视图
-(void)loadChoiceView{
    
    UIView *btnContainer = [[UIView alloc]init];
    _btnContainer = btnContainer;
    
    UIView *topline = [[UIView alloc] init];
    topline.backgroundColor = [UIColor lightGrayColor];
    [btnContainer addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnContainer);
        make.leading.trailing.equalTo(btnContainer);
        make.height.equalTo(@1);
    }];
    
    
    UIView *bottomline = [[UIView alloc] init];
    bottomline.backgroundColor = [UIColor lightGrayColor];
    [btnContainer addSubview:bottomline];
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnContainer.mas_bottom);
        make.leading.trailing.equalTo(btnContainer);
        make.height.equalTo(@1);
    }];
    
    btnContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnContainer];
    [btnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_cyView.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor lightGrayColor];
    [btnContainer addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(2);
        make.centerX.centerY.equalTo(btnContainer);
    }];
    
    /** 价格 */
    UIButton *priceBtn = [[UIButton alloc]init];
    [priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    priceBtn.titleLabel.adjustsFontSizeToFitWidth = YES;

    priceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [priceBtn addTarget:self action:@selector(priceClik) forControlEvents:UIControlEventTouchUpInside];
    [priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnContainer addSubview:priceBtn];
    [priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(btnContainer);
        make.right.equalTo(centerView.mas_left);
        
    }];
    
    /** 排序 */
    UIButton *sorteBtn = [[UIButton alloc]init];
    _sorteBtn = sorteBtn;
    sorteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sorteBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    sorteBtn.titleLabel.lineBreakMode = 0;

//    sorteBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [sorteBtn addTarget:self action:@selector(sorteClick) forControlEvents:UIControlEventTouchUpInside];
    [sorteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnContainer addSubview:sorteBtn];
    [sorteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(btnContainer);
        make.left.equalTo(centerView.mas_right);
    }];
    
    
}


//添加轮播图
- (void)verbView
{
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 160*SCREEN_WIDTH/375)];
    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"4"];
    [self.view addSubview:cyView];
}

//添加导航栏搜索
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
#pragma mark- 价格按钮的点击事件
//价格按钮点击事件
- (void)priceClik {
    if (_priceView == nil) {
        UIView *priceview = [UIView new];
        
        priceview.backgroundColor = [UIColor whiteColor];
        _priceView = priceview;
        [self.view addSubview:priceview];
        [priceview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(_btnContainer.mas_bottom).offset(1);
            make.height.mas_equalTo(100);
        }];
        [_sorteTableView removeFromSuperview];
        
        /** 最低价 */
        UILabel *minLab = [UILabel new];
        minLab.text = @"最低价(元):";
        minLab.font = [UIFont systemFontOfSize:14];
        [priceview addSubview:minLab];
        [minLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceview).offset(10);
            make.top.equalTo(priceview).offset(20);
        }];
        UITextField *minFild = [UITextField new];
        _minFild = minFild;
        [priceview addSubview:minFild];
        minFild.borderStyle = UITextBorderStyleRoundedRect;
        [priceview addSubview:minFild];
        [minFild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(minLab.mas_right).offset(5);
            make.centerY.equalTo(minLab);
            make.width.mas_equalTo(60);
        }];
        
        /** 最高价 */
        UILabel *maxLab = [UILabel new];
        maxLab.text = @"最高价(元):";
        maxLab.font = [UIFont systemFontOfSize:14];
        [priceview addSubview:maxLab];
        [maxLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceview).offset(10);
            make.top.equalTo(minLab.mas_bottom).offset(30);
        }];
        UITextField *maxFild = [UITextField new];
        _maxFild = maxFild;
        [priceview addSubview:maxFild];
        maxFild.borderStyle = UITextBorderStyleRoundedRect;
        [priceview addSubview:maxFild];
        [maxFild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(maxLab.mas_right).offset(5);
            make.centerY.equalTo(maxLab);
            make.width.mas_equalTo(60);
        }];
        
        /** 确定 */
        UIButton *carouselBtn = [UIButton new];
        [carouselBtn setTitle:@"确定" forState:UIControlStateNormal];
        carouselBtn.layer.cornerRadius = 5;
        carouselBtn.clipsToBounds = YES;
        carouselBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        carouselBtn.backgroundColor = [UIColor orangeColor];
        [carouselBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [carouselBtn addTarget:self action:@selector(carouselBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [priceview addSubview:carouselBtn];
        [carouselBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(priceview).offset(-10);
            make.centerY.equalTo(maxFild);
            make.width.mas_offset(40);
        }];
        
        /** 清空 */
        UIButton *clearBtn = [UIButton new];
        [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
        clearBtn.layer.cornerRadius = 5;
        clearBtn.clipsToBounds = YES;
        clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        clearBtn.backgroundColor = [UIColor orangeColor];
        [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearBtnClik) forControlEvents:UIControlEventTouchUpInside];
        [priceview addSubview:clearBtn];
        [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(carouselBtn.mas_left).offset(-10);
            make.centerY.equalTo(maxFild);
            make.width.mas_offset(40);
        }];
        
    }else if (_priceView != nil)
    {
        [_priceView removeFromSuperview];
        
    }
}

#define 清空按钮事件
-(void)clearBtnClik{
    NSLog(@"清空");
    //    传入参数掉接口
    [self.params setObject:@"" forKey:@"fmoney"];
    [self.params setObject:@"" forKey:@"lmoney"];
    [self.params setObject:@"" forKey:@"status"];
    [self loadData];
    [_priceView removeFromSuperview];
    [self.hotelTableView reloadData];
}

#pragma mark- 确定按钮点击事件
-(void)carouselBtnDidClick {
    NSLog(@"确定");
    
//    传入参数掉接口
    [self.params setObject:self.minFild.text forKey:@"fmoney"];
    [self.params setObject:self.maxFild.text forKey:@"lmoney"];
    [self loadData];
    
    [_priceView removeFromSuperview];
//    刷新UI
//    NSLog(@"====%@=====",self.minFild.text );
    [self.hotelTableView reloadData];
}

#pragma mark-排序按钮点击事件
- (void)sorteClick
{
    NSLog(@"智能排序");
    if (_sorteTableView == nil) {
        UITableView *sorteTableView = [[UITableView alloc]init];
        sorteTableView.dataSource = self;
        sorteTableView.delegate = self;
        //    注册排序cell
        [sorteTableView registerClass:[HEBsorteTableViewCell class] forCellReuseIdentifier:sorteCellID];
        sorteTableView.tag = 2;
        sorteTableView.backgroundColor = [UIColor whiteColor];
        _sorteTableView = sorteTableView;
        [self.view addSubview:sorteTableView];
        [sorteTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(_btnContainer.mas_bottom).offset(1);
            make.height.mas_equalTo(180);
        }];
        [_priceView removeFromSuperview];
        
        
        
        
    }else if (_sorteTableView != nil)
    {
        [_sorteTableView removeFromSuperview];
    }
    
}
#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.tag ==2) {
        HEBsorteTableViewCell * cell = (HEBsorteTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.sorteBtn.titleLabel.text = cell.titlLabel.text;
//        NSLog(@"--%@",cell.titlLabel.text);
        
        //    传入参数掉接口
        [self.params setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"status"];
//        NSLog(@"%@----",[self.params objectForKey:@"status"]);
        
        [self loadData];
        //点击后保存视图数据并移除视图
        [self.sorteTableView removeFromSuperview];
        [self.hotelTableView reloadData];
        
    }
    if (tableView.tag ==1) {
                //跳转到酒店详情VC
                HEBHotelDetailViewController *hotelDetailsVC = [[HEBHotelDetailViewController alloc]init];
        hotelDetailsVC.hotelid = self.hoteListArrayM[indexPath.row].h_id;
                [self.navigationController pushViewController:hotelDetailsVC animated:YES];
    }
    
}

#pragma mark- UITableViewDataSource 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%ld", tableView.tag);
    if (tableView.tag==2) {
        return 4;
    }
    
    return self.hoteListArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *sortList = @[@"综合排序",@"价格从低到高",@"价格从高到低",@"距离优先"];
    
    if (tableView.tag==2) {
        //排序cell
        HEBsorteTableViewCell *sorteCell = [tableView dequeueReusableCellWithIdentifier:sorteCellID forIndexPath:indexPath];
        sorteCell.titlLabel.text = sortList[indexPath.row];
        
        
        
        return sorteCell;
    }
    //酒店cell
    HEBHotelTableViewCell *hotelCell = [tableView dequeueReusableCellWithIdentifier:@"hotelCell" forIndexPath:indexPath];
    hotelCell.hotSellModel = self.hoteListArrayM[indexPath.row];
    hotelCell.selectionStyle = UITableViewCellSelectionStyleNone;  
    return hotelCell;
    
}
//列表参数
- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_params setObject:getCity_id forKey:@"city_id"];
        [_params setObject:getLon forKey:@"lng"];
        [_params setObject:getLat forKey:@"lat"];
    }
    return _params;
}


//列表模型数组
- (NSMutableArray *)hoteListArrayM {
    if (!_hoteListArrayM) {
        _hoteListArrayM = [NSMutableArray array];
    }
    return _hoteListArrayM;
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

@end

