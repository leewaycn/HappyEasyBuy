//
//  HEBReserveVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/2.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//房间预定页面
#define MaxFont 14
#define MiniFont 12
#define ViewHeihgt 40

#import "HEBReserveVC.h"
#import "HEBChooseCouponsViewController.h"


@interface HEBReserveVC ()<UITableViewDelegate,UITableViewDataSource>

@property(weak, nonatomic)UIView *topView;
//预订信息View
@property(weak, nonatomic)UIView *newsView ;
//优惠券View
@property(weak, nonatomic)UIView *couponView;
/** 存储请求信息 */
@property(nonatomic,strong) NSMutableDictionary *params;
//价格按钮
@property(nonatomic, weak)UIButton *priceButton;
//    选择到店时间tabView
@property(nonatomic, weak) UITableView *arriveTimeTabVIew;

@end


static NSString *cellID = @"cellID";
@implementation HEBReserveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    
    [self loadData];
    [self setupUI];
    [self loadnewsView];
    [self addCouponView];
    [self addInvoiceView];
    [self addArriveTimeTabView];
}

-(void)loadData{
//    参数
//    h_id
//    酒店ID
//    r_id
//    房间ID
//    uid
//    用户id
//    Shop_id
//    店铺id
//    Shop_type
//    店铺类型

//    6.房间预订页面接口
//    http://luntan.guoxiangou.cn/Home/Room/hotel_room_rese
//    7.房间预订接口
//    http://luntan.guoxiangou.cn/Home/Room/hotel_room_reses

    NSString *url = @"Home/Room/hotel_room_rese";
    
    [_params setObject:self.h_id forKey:@"Shop_id"];
    [_params setObject:self.h_id forKey:@"h_id"];
    [_params setObject:self.r_id forKey:@"r_id"];
    [Networking postUrl:url params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
       
        NSLog(@"%@-----%@----%@------%@",self.h_id,self.r_id,getUser_id,response);
    }];
    
}

-(void)setupUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 80)];
    _topView = topView;
    topView.dividingLine = YES;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
//    房间名称
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"房间名称";
    nameLabel.font = [UIFont systemFontOfSize:MaxFont];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(topView).offset(10);
    }];
//    入住
    UILabel *checkLabel = [UILabel new];
    checkLabel.text = @"入住：2018-1-1";
    checkLabel.font = [UIFont systemFontOfSize:MiniFont];
    [topView addSubview:checkLabel];
    [checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.centerY.equalTo(topView);
    }];
//    离店
    UILabel *leaveLabel = [UILabel new];
    leaveLabel.text = @"离店：2018-1-2";
    leaveLabel.font = [UIFont systemFontOfSize:MiniFont];
    [topView addSubview:leaveLabel];
    [leaveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(topView);
    }];
//    入住天数
    UILabel *numberDayLabel = [UILabel new];
    numberDayLabel.text = @"共1天";
    numberDayLabel.font = [UIFont systemFontOfSize:MiniFont];
    [topView addSubview:numberDayLabel];
    [numberDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-20);
        make.centerY.equalTo(topView);
    }];
//    提示核对信息
    UILabel *promptLabel = [UILabel new];
    promptLabel.text = @"请仔细核对入住信息";
    promptLabel.textColor = [UIColor orangeColor];
    promptLabel.font = [UIFont systemFontOfSize:MiniFont];
    [topView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.bottom.equalTo(topView).offset(-10);
    }];
}

//预定信息
-(void)loadnewsView{
    
    UIView *newsView = [UIView new];
    _newsView = newsView;
    newsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newsView];
    [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(_topView.mas_bottom).offset(5);
        make.height.mas_offset(160);
    }];
//    房间数
    UIView *roomNumberView = [UIView new];
    roomNumberView.bottomLine = YES;
    roomNumberView.backgroundColor = [UIColor whiteColor];
    [newsView addSubview:roomNumberView];
    [roomNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newsView);
        make.width.equalTo(newsView);
        make.height.mas_offset(ViewHeihgt);
    }];
    UILabel *roomTitilLabel = [[UILabel alloc]init];
    roomTitilLabel.text = @"房间数";
    roomTitilLabel.font = [UIFont systemFontOfSize:MaxFont];
    [roomNumberView addSubview:roomTitilLabel];
    [roomTitilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomNumberView).offset(10);
        make.centerY.equalTo(roomNumberView);
    }];
//    房间数输入文本框
    UITextField *roomNumberTextField = [[UITextField alloc]init];
    roomNumberTextField.placeholder = @"1";
    roomNumberTextField.font = [UIFont systemFontOfSize:MaxFont];
    [roomNumberView addSubview:roomNumberTextField];
    [roomNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(roomNumberView);
        make.width.mas_offset(40);
    }];
//最大订购Label
    UILabel *maxNumberLabel = [UILabel new];
    maxNumberLabel.text = @"最大订购房间数2";
    maxNumberLabel.font = [UIFont systemFontOfSize:MaxFont];
    [roomNumberView addSubview:maxNumberLabel];
    [maxNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(roomNumberView).offset(-10);
        make.centerY.equalTo(roomNumberView);
    }];

//  姓名
    UIView *namerView = [UIView new];
    namerView.bottomLine = YES;
    [roomNumberView addSubview:namerView];
    [namerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(roomNumberView);
        make.top.equalTo(roomNumberView.mas_bottom);
        make.height.mas_offset(ViewHeihgt);
    }];
    
    UILabel *namerTitlLabel = [UILabel new];
    namerTitlLabel.text = @"姓名";
    namerTitlLabel.font = [UIFont systemFontOfSize:MaxFont];
    [namerView addSubview:namerTitlLabel];
    [namerTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(namerView).offset(10);
        make.centerY.equalTo(namerView);
    }];
//    名字输入框
    UITextField *nameTextField = [UITextField new];
    nameTextField.placeholder = @"请输入姓名";
    nameTextField.font = [UIFont systemFontOfSize:MaxFont];
    [namerView addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(namerView);
        make.width.mas_offset(120);
    }];
    
//    联系方式
    UIView *phoneView = [UIView new];
    phoneView.bottomLine = YES;
    [roomNumberView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(roomNumberView);
        make.top.equalTo(namerView.mas_bottom);
        make.height.mas_offset(ViewHeihgt);
    }];
    UILabel *phoneTitlLabel = [UILabel new];
    phoneTitlLabel.text = @"联系手机";
    phoneTitlLabel.font = [UIFont systemFontOfSize:MaxFont];
    [phoneView addSubview:phoneTitlLabel];
    [phoneTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneView).offset(10);
        make.centerY.equalTo(phoneView);
    }];
//    手机号码输入框
    UITextField *phoneTextField = [UITextField new];
    phoneTextField.font = [UIFont systemFontOfSize:MaxFont];
    phoneTextField.text = @"12345678";
    [phoneView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(phoneView);
//        make.width.mas_offset(100);
    }];
//    预计到店时间
    UIView *arriveView = [UIView new];
    arriveView.bottomLine = YES;
//    添加View点击事件
    UITapGestureRecognizer *arriveGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(arriveViewClik:)];
    [arriveGesturRecognizer setNumberOfTapsRequired:1];
    [arriveView addGestureRecognizer:arriveGesturRecognizer];
    
        [newsView addSubview:arriveView];
        [arriveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(roomNumberView);
            make.top.equalTo(phoneView.mas_bottom);
            make.height.mas_offset(ViewHeihgt);
    }];
    
    UILabel *arriveTitlLabel = [UILabel new];
    arriveTitlLabel.text =@"预计到店";
    arriveTitlLabel.font = [UIFont systemFontOfSize:MaxFont];
    [arriveView addSubview:arriveTitlLabel];
    [arriveTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arriveView).offset(10);
        make.centerY.equalTo(arriveView);
    }];
//    到店时间Label
    UILabel *arriveTimeLabel = [UILabel new];
    arriveTimeLabel.text = @"18：00之前";
    arriveTimeLabel.font = [UIFont systemFontOfSize:MaxFont];
    [arriveView addSubview:arriveTimeLabel];
    [arriveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(arriveView);
    }];
    
    UIImageView *arriveImageView = [UIImageView new];
    arriveImageView.image = [UIImage imageNamed:@"xiangyou"];
    [arriveView addSubview: arriveImageView ];
    [arriveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arriveView).offset(-10);
        make.centerY.equalTo(arriveView);
        
    }];
    
}

-(void)addCouponView{
    //    优惠券View
    UIView *couponView = [UIView new];
    _couponView = couponView;
    couponView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:couponView];
    [couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.newsView.mas_bottom).offset(5);
        make.height.mas_offset(80);
    }];
    //    商家优惠券
    UIView *businessCouponView = [UIView new];
    businessCouponView.bottomLine = YES;
//    点击事件
    UITapGestureRecognizer *businessCouponGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(businessCouponViewClik:)];
    [businessCouponGesturRecognizer setNumberOfTapsRequired:1];
    [businessCouponView addGestureRecognizer:businessCouponGesturRecognizer];
    
    businessCouponView.backgroundColor = [UIColor whiteColor];
    [couponView addSubview:businessCouponView];
    [businessCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(couponView);
        make.top.equalTo(couponView);
        make.height.mas_offset(ViewHeihgt);
    }];
    
    UILabel *businessCouponTitlLabel = [UILabel new];
    businessCouponTitlLabel.text = @"商家优惠券";
    businessCouponTitlLabel.font = [UIFont systemFontOfSize:MaxFont];
    [businessCouponView addSubview:businessCouponTitlLabel];
    [businessCouponTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(businessCouponView).offset(10);
        make.centerY.equalTo(businessCouponView);
    }];
    
    UIImageView *businessCouponImageView = [UIImageView new];
    businessCouponImageView.image = [UIImage imageNamed:@""];
    [businessCouponView addSubview: businessCouponImageView];
    [businessCouponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(businessCouponView).offset(-10);
        make.centerY.equalTo(businessCouponView);
        make.width.height.mas_offset(30);
        
    }];
    
    UILabel *businessCouponNumberLabel = [UILabel new];
    businessCouponNumberLabel.text = @"暂无可用优惠券";
    businessCouponNumberLabel.font = [UIFont systemFontOfSize:MiniFont];
    [businessCouponView addSubview:businessCouponNumberLabel];
    [businessCouponNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(businessCouponImageView.mas_left);
        make.centerY.equalTo(businessCouponView);
    }];
    
//    通用优惠券View
    UIView *currencyCouponView = [UIView new];
    currencyCouponView.bottomLine = YES;
    currencyCouponView.backgroundColor = [UIColor whiteColor];
    //    点击事件
    UITapGestureRecognizer *currencyCouponGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(currencyCouponCouponViewClik:)];
    [currencyCouponGesturRecognizer setNumberOfTapsRequired:1];
    [currencyCouponView addGestureRecognizer:currencyCouponGesturRecognizer];
    
    
    [couponView addSubview:currencyCouponView];
    [currencyCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(businessCouponView.mas_bottom);
        make.width.equalTo(couponView);
        make.height.mas_offset(40);
    }];
    
    UILabel *currencyCouponTitlLabel = [UILabel new];
    currencyCouponTitlLabel.text =@"通用优惠券";
    currencyCouponTitlLabel.font = [UIFont systemFontOfSize:MaxFont];
    [currencyCouponView addSubview:currencyCouponTitlLabel];
    [currencyCouponTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currencyCouponView).offset(10);
        make.centerY.equalTo(currencyCouponView);
    }];
    
    UIImageView *currencyCouponImageView = [UIImageView new];
    currencyCouponImageView.image = [UIImage imageNamed:@""];
    [currencyCouponView addSubview:currencyCouponImageView];
    [currencyCouponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(currencyCouponView).offset(-10);
        make.centerY.equalTo(currencyCouponView);
        make.width.height.mas_offset(30);
    }];
    
    UILabel *currencyCouponNumberLabel = [UILabel new];
    currencyCouponNumberLabel.text = @"暂无可用优惠券";
    currencyCouponNumberLabel.font = [UIFont systemFontOfSize:MiniFont];
    [currencyCouponView addSubview:currencyCouponNumberLabel];
    [currencyCouponNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(currencyCouponImageView.mas_left);
        make.centerY.equalTo(currencyCouponView);
    }];
    
}
//add发票View
-(void)addInvoiceView{
    
    UIView *invoiceView = [UIView new];
    invoiceView.bottomLine = YES;
    invoiceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:invoiceView];
    [invoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.couponView.mas_bottom).offset(5);
        make.height.mas_offset(40);
    }];
    
    UILabel *invoiceTitlLabel = [UILabel new];
    invoiceTitlLabel.text = @"发票";
    invoiceTitlLabel.font = [UIFont systemFontOfSize:MaxFont];
    [invoiceView addSubview:invoiceTitlLabel];
    [invoiceTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(invoiceView).offset(10);
        make.centerY.equalTo(invoiceView);
    }];
    
    UILabel *invoiceLabel = [UILabel new];
    invoiceLabel.text = @"如需发票,请向前台咨询";
    invoiceLabel.font = [UIFont systemFontOfSize:MaxFont];
    [invoiceView addSubview:invoiceLabel];
    [invoiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(invoiceView);
        make.centerX.equalTo(invoiceView).offset(30);
        
    }];
    
//    价格btn
    UIButton *priceButton = [UIButton new];
    _priceButton = priceButton;
    [priceButton setTitle:@"￥" forState:UIControlStateNormal];
    [priceButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    priceButton.titleLabel.font = [UIFont systemFontOfSize:MaxFont];
    priceButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:priceButton];
    [priceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
        make.height.mas_offset(50);
    }];
    
//    预定按钮
    UIButton *reserveButton = [UIButton new];
    reserveButton.backgroundColor = [UIColor orangeColor];
    [reserveButton setTitle:@"预定" forState:UIControlStateNormal];
    [reserveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reserveButton addTarget:self action:@selector(reserveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    [reserveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
        make.height.mas_offset(50);
    }];
    
//    //    选择到店时间tabView
//    UITableView *arriveTimeTabView = [UITableView new];
//    arriveTimeTabView.scrollEnabled = NO;
//    arriveTimeTabView.dividingLine = YES;
//    arriveTimeTabView.delegate = self;
//    arriveTimeTabView.dataSource = self;
//    _arriveTimeTabVIew = arriveTimeTabView;
//    arriveTimeTabView.backgroundColor = [UIColor whiteColor];
//    [arriveTimeTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
//    [self.view addSubview:arriveTimeTabView];
//    [arriveTimeTabView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.bottom.equalTo(_priceButton);
//        make.height.mas_offset(280);
//    }];
//    arriveTimeTabView.hidden = YES;
//
////    arriveTimeTabVIew的表头视图
//    UIView *arriveTimeTabVIewHeadV= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
//    arriveTimeTabVIewHeadV.bottomLine = YES;
//    UILabel *arrivalTimeTitl = [UILabel new];
//    arrivalTimeTitl.text = @"到达时间";
//    arrivalTimeTitl.font = [UIFont systemFontOfSize:MaxFont];
//    [arriveTimeTabVIewHeadV addSubview:arrivalTimeTitl];
//    [arrivalTimeTitl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(arriveTimeTabVIewHeadV).offset(10);
//    }];
//
//    UILabel *arrivalTimePromptLabel = [UILabel new];
//    arrivalTimePromptLabel.textColor = [UIColor grayColor];
//    arrivalTimePromptLabel.text = @"房间整晚保留";
//    arrivalTimePromptLabel.font = [UIFont systemFontOfSize:12];
//    [arriveTimeTabVIewHeadV addSubview:arrivalTimePromptLabel];
//    [arrivalTimePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(arrivalTimeTitl);
//        make.bottom.equalTo(arriveTimeTabVIewHeadV).offset(-5);
//    }];
//
//    //    添加表头视图
//    arriveTimeTabView.tableHeaderView = arriveTimeTabVIewHeadV;
//
//    UIButton *arriveTimeCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    arriveTimeCloseBtn.dividingLine = YES;
//    [arriveTimeCloseBtn setTitle:@"关闭" forState:UIControlStateNormal];
//    [arriveTimeCloseBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
////    添加表尾视图
//    arriveTimeTabView.tableFooterView = arriveTimeCloseBtn;
}


#pragma mark-//到店时间TabView
-(void)addArriveTimeTabView{
    
    //    选择到店时间tabView
    UITableView *arriveTimeTabView = [UITableView new];
    arriveTimeTabView.scrollEnabled = NO;
    arriveTimeTabView.dividingLine = YES;
    arriveTimeTabView.delegate = self;
    arriveTimeTabView.dataSource = self;
    _arriveTimeTabVIew = arriveTimeTabView;
    arriveTimeTabView.backgroundColor = [UIColor whiteColor];
    [arriveTimeTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:arriveTimeTabView];
    [arriveTimeTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.bottom.equalTo(_priceButton);
        make.height.mas_offset(280);
    }];
    arriveTimeTabView.hidden = YES;
    
    //    arriveTimeTabVIew的表头视图
    UIView *arriveTimeTabVIewHeadV= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    arriveTimeTabVIewHeadV.bottomLine = YES;
    UILabel *arrivalTimeTitl = [UILabel new];
    arrivalTimeTitl.text = @"到达时间";
    arrivalTimeTitl.font = [UIFont systemFontOfSize:MaxFont];
    [arriveTimeTabVIewHeadV addSubview:arrivalTimeTitl];
    [arrivalTimeTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(arriveTimeTabVIewHeadV).offset(10);
    }];
    
    UILabel *arrivalTimePromptLabel = [UILabel new];
    arrivalTimePromptLabel.textColor = [UIColor grayColor];
    arrivalTimePromptLabel.text = @"房间整晚保留";
    arrivalTimePromptLabel.font = [UIFont systemFontOfSize:12];
    [arriveTimeTabVIewHeadV addSubview:arrivalTimePromptLabel];
    [arrivalTimePromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrivalTimeTitl);
        make.bottom.equalTo(arriveTimeTabVIewHeadV).offset(-5);
    }];
    
    //    添加表头视图
    arriveTimeTabView.tableHeaderView = arriveTimeTabVIewHeadV;
    
    UIButton *arriveTimeCloseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    arriveTimeCloseBtn.dividingLine = YES;
    [arriveTimeCloseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [arriveTimeCloseBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //    添加表尾视图
    arriveTimeTabView.tableFooterView = arriveTimeCloseBtn;
}


//UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//[tapGesture setNumberOfTapsRequired:1];
//[tapView addGestureif (_arriveTimeTabVIew.hidden != NO) {
//        _arriveTimeTabVIew.hidden = NO;
//    }
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = @[@"18:00之前",@"20:00之前",@"23:59之前",@"次日凌晨6:00之前"];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:12];
    
    return cell;
}

#pragma mark-到店时间View事件
-(void)arriveViewClik:(id)arriveView
{
    NSLog(@"点击了到店时间arriveView");
    self.arriveTimeTabVIew.hidden = NO;
   
}

#pragma mark -商家优惠券View点击事件
-(void)businessCouponViewClik:(id)businessCouponView{
    
    NSLog(@"点击商家优惠券");
    
}

#pragma mark-通用优惠券View点击事件
-(void)currencyCouponCouponViewClik:(id)currencyCouponCouponView{
    
    NSLog(@"点击通用优惠券View");
    
    HEBChooseCouponsViewController *chooseCouponsViewController = [HEBChooseCouponsViewController new];
//** 需要传参 */
    
    [self.navigationController pushViewController:chooseCouponsViewController animated:YES];
}
#pragma mark-预定按钮点击事件
-(void)reserveButton:(UIButton*)reserveButton{
    
    NSLog(@"点击预定按钮");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.arriveTimeTabVIew.hidden = YES;


}






//    参数
//    h_id
//    酒店ID
//    r_id
//    房间ID
//    uid
//    用户id
//    Shop_id
//    店铺id
//    Shop_type
//    店铺类型
//列表参数
- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:@"4" forKey:@"Shop_type"];
        [_params setObject:getUser_id forKey:@"uid"];
    }
    return _params;
}

@end
