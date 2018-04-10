//
//  HEBentertainmentViewController.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//


#define ButtonFont 12

#import "HEBLeisureViewController.h"
#import "ClassificationsView.h"
#import "HEBEntertainmentistTabViewCell.h"
#import "HEBEntertainmentDetailsVC.h"
#import "HEBSearchViewController.h"
#import "HEBEntertainmentClassifyVC.h"
#import "HEBLeisureListModel.h"
#import "HEBLeisureClassModel.h"
@interface HEBLeisureViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 搜索btn */
@property(nonatomic, strong) QMUIButton *searchBtn;
//分类视图
@property(nonatomic, strong) ClassificationsView *classificationsView;
//休闲娱乐tabView
@property(nonatomic, strong) UITableView *leisuretTableview;
//分类按钮容器视图
@property (nonatomic, strong) UIView *buttonView;
//滚动条
@property (nonatomic, strong) UIView *slideview;
//分类按钮数组
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnMutableArray;
/** 临时存储页码 */
@property(nonatomic, assign) int page;
/** 存储分类请求信息 */
@property(nonatomic,strong) NSMutableDictionary *classparams;
/** 存储列表请求信息 */
@property(nonatomic,strong) NSMutableDictionary *listparams;
//分类模型数组
@property(assign, nonatomic) NSArray <HEBClassificationModel *>*leisureClassArraM;
//列表模型数组
@property(nonatomic, strong) NSMutableArray <HEBLeisureListModel *>*leisureListArrayM;

@end

static NSString *entertainmentCell = @"entertainmentCell";
static NSString *header = @"header";

@implementation HEBLeisureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    self.page = 1;
    [self loadLeisureClasData];
    
    [self loadSearchView];
//    [self setupUI];
  
}
#pragma mark - 请求分类数据
-(void)loadLeisureClasData{

//    分类的{"cate_id":"3","city_id":"147"}
//        public static final String AllClass = TUrl + "/Home/Foods/allClass";//点击全部下拉分类接口
    NSString *url = @"Home/Foods/allClass";
    
    [self.classparams setObject:@"3" forKey:@"cate_id"];
    
    [Networking postUrl:url params:self.classparams callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [self loadLeisureListData];
        if ([response[@"status"] integerValue] == 1) {
            
            NSLog(@"%@", response);
            
            self.leisureClassArraM = [NSArray yy_modelArrayWithClass:[HEBClassificationModel class] json:mainModel.data];
            
            [self.listparams setValue:self.leisureClassArraM[0].objid forKey:@"cid"];

            [self setupUI];
            
        }
        
    }];
    
    
}

#pragma mark-//请求列表数据
-(void)loadLeisureListData{
//    休闲娱乐列表参数: jsonObject={"index_page":1,"index_size":10,"lng":118.244739,"lat":35.005517,"cid":12,"city_id":"147"}
    //列表接口
//http://luntan.guoxiangou.cn/Home/Happy/foot_list
    NSString *url = @"Home/Happy/foot_list";
    
//    [self.listparams setObject:@"1" forKey:@"cid"];
    [Networking postUrl:url params:self.listparams callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        self.leisureListArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBLeisureListModel class] json:mainModel.data]];
//        刷新数据
        [self.leisuretTableview reloadData];
//        NSLog(@"%@============",response);
    }];
}


-(void)setupUI{
    //创建并添加一个tableView
    UITableView *leisuretTableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    leisuretTableview.backgroundColor = [UIColor redColor];
//    leisuretTableview.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    _leisuretTableview = leisuretTableview;
    [self.view addSubview:leisuretTableview];
    leisuretTableview.delegate = self;
    leisuretTableview.dataSource = self;
//    注册cell
  [leisuretTableview registerClass:[HEBEntertainmentistTabViewCell class] forCellReuseIdentifier:entertainmentCell];
    
//    顶部容器视图
    UIView *basView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 260)];
    basView.backgroundColor = [UIColor whiteColor];
    self.leisuretTableview.tableHeaderView = basView;
    
    //分类视图
    ClassificationsView *classificationsView = [[ClassificationsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _classificationsView = classificationsView;
    [basView addSubview:classificationsView];
    [classificationsView setClassificationsViewDataArr:self.leisureClassArraM maxRowCount:5 maxRow:2 didClickClassifications:^(HEBClassificationModel *model) {
        
        HEBEntertainmentClassifyVC *entertainmentClassifyVC = [[HEBEntertainmentClassifyVC alloc]init];
        entertainmentClassifyVC.objid = model.objid;
        [self.navigationController pushViewController:entertainmentClassifyVC animated:YES];
    }];
    
    
//按钮容器
    UIView *buttonView = [[UIView alloc]init];
    buttonView.dividingLine = YES;
    buttonView.backgroundColor  = [UIColor whiteColor];
    [basView addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(basView);
        make.height.mas_offset(50);
        
    }];
    self.buttonView = buttonView;
    UIView *topline = [[UIView alloc] init];
    topline.backgroundColor = [UIColor whiteColor];
    [buttonView addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView);
        make.leading.trailing.equalTo(buttonView);
        make.height.equalTo(@1);
    }];
    
    for (int i = 0; i < self.leisureClassArraM.count; i++) {
        HEBClassificationModel *model =  self.leisureClassArraM[i];
        UIButton *btn = [[UIButton alloc]init];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
//        objid绑定到按钮的tag值上面
        btn.tag = [model.objid intValue];
        btn.titleLabel.lineBreakMode = 0;
        [btn setTitle:self.leisureClassArraM[i].name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(buttonView);
            make.width.mas_offset(SCREEN_WIDTH/4);
            make.left.equalTo(buttonView.mas_left).offset(i*(SCREEN_WIDTH/4));
        }];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnMutableArray addObject:btn];
    }
    
    UIView *slideview = [[UIView alloc]init];
    self.slideview = slideview;
    slideview.backgroundColor = [UIColor orangeColor];
    [buttonView addSubview:slideview];
    slideview.size = CGSizeMake(SCREEN_WIDTH/4, 3);
    slideview.left = 0;
    slideview.bottom = 50;
    UIView *bottomline = [[UIView alloc] init];
    bottomline.backgroundColor = [UIColor lightGrayColor];
    [buttonView addSubview:bottomline];
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.mas_bottom);
        make.leading.trailing.equalTo(buttonView);
        make.height.equalTo(@1);
    }];
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



#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leisureListArrayM.count;
//    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //休闲娱乐列表cell
    HEBEntertainmentistTabViewCell *entertainmentCell = [tableView dequeueReusableCellWithIdentifier:@"entertainmentCell" forIndexPath:indexPath];
    
    entertainmentCell.leisureListModel = self.leisureListArrayM[indexPath.row];
    
    entertainmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return entertainmentCell;
    
}

#pragma mark-UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HEBEntertainmentDetailsVC *entertainmentDetailsVC = [[HEBEntertainmentDetailsVC alloc]init];
    entertainmentDetailsVC.ha_id = self.leisureListArrayM[indexPath.row].ha_id;
    entertainmentDetailsVC.lat = self.leisureListArrayM[indexPath.row].lat;
    entertainmentDetailsVC.lat = self.leisureListArrayM[indexPath.row].lng;
    [self.navigationController pushViewController:entertainmentDetailsVC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell高度
    return 80;
}

#pragma mark-分类按钮点击事件
-(void)btnClick:(UIButton *)sender{

    [self.leisureListArrayM removeAllObjects];
    [UIView animateWithDuration:0.25 animations:^{
        self.slideview.centerX = sender.centerX;
    }];
    [self.btnMutableArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        根据绑定到按钮tag值上的objid判断
        if (obj.tag == sender.tag) {
            [obj setTitleColor:BASECOLOR forState:UIControlStateNormal];
        }else {
            [obj setTitleColor:UIColorBlack forState:UIControlStateNormal];
        }
    }];

    [self.listparams setValue:@(sender.tag) forKey:@"cid"];
    
    NSString *url = @"Home/Happy/foot_list";
    [Networking postUrl:url params:self.listparams callBack:^(id response, MainModel *mainModel, NSError *errorData) {
//        NSLog(@"%@============",response);
        if ([response[@"status"] intValue] == 1) {
            
            self.leisureListArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBLeisureListModel class] json:mainModel.data]];
        }
        //        刷新数据
        [self.leisuretTableview reloadData];
        
    }];
    
    
    
}

//分类请求参数
- (NSMutableDictionary *)classparams {
    if (!_classparams) {
        _classparams = [NSMutableDictionary dictionary];
        [_classparams setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_classparams setObject:getCity_id forKey:@"city_id"];
        [_classparams setObject:getLon forKey:@"lng"];
        [_classparams setObject:getLat forKey:@"lat"];
    }
    return _classparams;
}
//列表请求参数
- (NSMutableDictionary *)listparams {
    if (!_listparams) {
        _listparams = [NSMutableDictionary dictionary];
        [_listparams setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_listparams setObject:getCity_id forKey:@"city_id"];
        [_listparams setObject:getLon forKey:@"lng"];
        [_listparams setObject:getLat forKey:@"lat"];
    }
    return _listparams;
}

//分类模型数组
-(NSArray *)LeisureClassArraM{
    if (!_leisureClassArraM) {
        _leisureClassArraM = [NSArray array];
    }
    return _leisureClassArraM;
}
//列表模型数组
-(NSMutableArray *)leisureListArrayM{
    if (!_leisureListArrayM) {
        _leisureListArrayM = [NSMutableArray array];
    }
    return _leisureListArrayM;
}


- (NSMutableArray<UIButton *> *)btnMutableArray {
    if (!_btnMutableArray) {
        _btnMutableArray = [NSMutableArray array];
    }
    return _btnMutableArray;
}
@end
