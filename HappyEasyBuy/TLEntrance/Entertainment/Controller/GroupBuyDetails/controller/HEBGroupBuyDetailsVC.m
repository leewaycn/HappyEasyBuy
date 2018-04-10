//
//  HEBgroupBuyDetailsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/1.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBGroupBuyDetailsVC.h"
#import "HEBGroupBuyDetailsBackView.h"
#import "HEBPlaceOrderVC.h"
#import "HEBKTVSetMealCell.h"
#import "HEBKTVNoticeCell.h"
#import "HEBGroupBuyDetailsModel.h"
#import "HEBPackagesModel.h"

#define kUISCREENWIDTH  [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define kUISCREENHEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度
@interface HEBGroupBuyDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HEBGroupBuyDetailsBackView *  backViewKtv;
//模型
@property(nonatomic, strong)HEBGroupBuyDetailsModel *groupBuyDetailsModel;
//团购套餐数组模型
@property(nonatomic, strong)NSMutableArray <HEBPackagesModel*>*packagesArrayM;


@property(nonatomic, weak) UITableView  *tableView1;

@property(nonatomic, weak) UITableView  *tableView2;

@property(nonatomic, weak) UITableView  *tableView3;

//    总价
@property(nonatomic, weak) UILabel *totalLabel;
//团购价
@property(nonatomic, weak)UILabel *groupPriceLabel;

@end

static NSString *cell1 = @"cellID1";
static NSString *cell2 = @"cellID2";
static NSString *cell3 = @"cellID3";

@implementation HEBGroupBuyDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNetworKing];
    [self creatUI];
    
}

-(void)loadNetworKing{
    //套餐id
//    @property(nonatomic, copy)NSString *f_id;
//    //当前经度
//    @property(nonatomic, copy)NSString *lat;
//    //当前纬度
//    @property(nonatomic, copy)NSString *lng;
    
//    http://luntan.guoxiangou.cn/Home/Happy/foot_package_info
    NSString *url = @"Home/Happy/foot_package_info";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.f_id forKey:@"f_id"];
    [params setObject:getLat forKey:@"lat"];
    [params setObject:getLon forKey:@"lng"];
    
    [Networking postUrl:url params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
//        NSLog(@"%@",response);
        self.groupBuyDetailsModel = [HEBGroupBuyDetailsModel yy_modelWithJSON:mainModel.data];

        //    赋值模型
        self.backViewKtv.groupBuyDetailsModel = self.groupBuyDetailsModel;
        
        
        
        [self.tableView1 reloadData];
        [self.tableView3 reloadData];
    }];
 
}

-(void)creatUI{
    self.backViewKtv = [[HEBGroupBuyDetailsBackView alloc]initWithFrame:CGRectMake(0, 0, kUISCREENWIDTH, kUISCREENHEIGHT)];
    
    [self.backViewKtv creatUI];

    self.backViewKtv.optionBlock = ^(int page) {
        //滚动底部的tableView或者点击分段选择器的 针对底部3个tableView的操作
        NSLog(@"%d",page);
    };
    [self.view addSubview:self.backViewKtv];
    
    //给backViewKtv的tableScroll  添加tableview
    UITableView * tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kUISCREENWIDTH, kUISCREENHEIGHT-100) style:UITableViewStylePlain];
    _tableView1 = tableView1;
    tableView1.backgroundColor = [UIColor whiteColor];
    tableView1.tag = 1;
    tableView1.bounces = NO;
    tableView1.delegate = self;
    tableView1.dataSource = self;
//    注册cell
    [tableView1 registerClass:[HEBKTVSetMealCell class] forCellReuseIdentifier:cell1];
    [self.backViewKtv.tableScroll addSubview:tableView1];
    
    UITableView * tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(kUISCREENWIDTH, 0, kUISCREENWIDTH, kUISCREENHEIGHT-100) style:UITableViewStylePlain];
    _tableView2 = tableView2;
    tableView2.backgroundColor = [UIColor greenColor];
    tableView2.tag = 2;
    tableView2.bounces = NO;
//    tableView2.delegate = self;
//    tableView2.dataSource = self;
    [self.backViewKtv.tableScroll addSubview:tableView2];
    
    UITableView * tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(kUISCREENWIDTH*2, 0, kUISCREENWIDTH, kUISCREENHEIGHT-100) style:UITableViewStylePlain];
    _tableView3 = tableView3;
    tableView3.backgroundColor = [UIColor whiteColor];
    tableView3.tag = 3;
    tableView3.bounces = NO;
    tableView3.delegate = self;
    tableView3.dataSource =self;
//    注册cell
    [tableView3 registerClass:[HEBKTVNoticeCell class] forCellReuseIdentifier:cell3];
    [self.backViewKtv.tableScroll addSubview:tableView3];
    

    //    金额
    UIButton *leftMoneyBtn = [UIButton new];
//    _leftMoneyBtn = leftMoneyBtn;
    [leftMoneyBtn setTitle:[NSString stringWithFormat:@"￥%@",self.f_price] forState:UIControlStateNormal];
    [leftMoneyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    leftMoneyBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftMoneyBtn];
    [leftMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(40);
    }];
    
    //    立即抢购按钮
    UIButton *rightReserveBtn = [UIButton new];
    [rightReserveBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [rightReserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightReserveBtn.backgroundColor = [UIColor orangeColor];
    [rightReserveBtn addTarget:self action:@selector(rightReserveBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightReserveBtn];
    [rightReserveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(40);
        
    }];
    
    UIView *tablViewVHead1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    tablViewVHead1.bottomLine = YES;
    
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [UIColor orangeColor];
    [tablViewVHead1 addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tablViewVHead1).offset(10);
        make.centerY.equalTo(tablViewVHead1);
        make.width.mas_offset(2);
        make.height.mas_offset(30);
    }];
    
    UILabel *headTitlLabel = [UILabel new];
    headTitlLabel.text = @"套餐测试-";
    [tablViewVHead1 addSubview:headTitlLabel];
    [headTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLine).offset(10);
        make.centerY.equalTo(tablViewVHead1);
    }];
    
//    添加表头视图
    tableView1.tableHeaderView = tablViewVHead1;
    
//    表尾
    UIView *tableViewFooter1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
//    总价
    UILabel *totalLabel = [UILabel new];
    [tableViewFooter1 addSubview:totalLabel];
    totalLabel.text = @"￥998";
    totalLabel.text = self.f_pic;
    totalLabel.font = [UIFont systemFontOfSize:14];
    [tableViewFooter1 addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(tableViewFooter1).offset(-10);
    }];
    
    UILabel *totalTitlLabel = [UILabel new];
    totalTitlLabel.text = @"总价";
    totalTitlLabel.font = [UIFont systemFontOfSize:14];
    [tableViewFooter1 addSubview:totalTitlLabel];
    [totalTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalLabel.mas_left).offset(-50);
        make.centerY.equalTo(totalLabel);
    }];
//    团购价
    UILabel *groupPriceLabel = [UILabel new];
    _groupPriceLabel = groupPriceLabel;
    groupPriceLabel.text = @"￥666";
    groupPriceLabel.text = self.f_price;
    groupPriceLabel.textColor = [UIColor orangeColor];
    groupPriceLabel.font = [UIFont systemFontOfSize:14];
    [tableViewFooter1 addSubview:groupPriceLabel];
    [groupPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalLabel);
        make.bottom.equalTo(tableViewFooter1).offset(-10);
    }];
    
    UILabel *groupTitlPriceLabel = [UILabel new];
    groupTitlPriceLabel.text = @"团购价";
    groupTitlPriceLabel.font = [UIFont systemFontOfSize:14];
    [tableViewFooter1 addSubview:groupTitlPriceLabel];
    [groupTitlPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalTitlLabel);
        make.centerY.equalTo(groupPriceLabel);
    }];
    tableView1.tableFooterView = tableViewFooter1;
    
//    self.totalLabel.text = self.groupBuyDetailsModel.f_oprice;
    
//    self.groupPriceLabel.text = self.groupBuyDetailsModel.f_price;
    

}
#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 3) {
        return 7;
    }
    
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 1) {
        HEBKTVSetMealCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1 forIndexPath:indexPath];
     //选中状态颜色为无色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    
//    if (tableView.tag= 2) {
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    __weak typeof(self)weakSelf = self;
//    HEBPackageDetailsAppraiseModel *model = self.roomCommentArrayM[indexPath.row];
//    HEBPackageDetailsAppraiseView *appraiseView = [[HEBPackageDetailsAppraiseView alloc] init];
//    [appraiseView.header yy_setImageWithURL:[NSURL URLWithString:model.headimg] options:YYWebImageOptionProgressive];
//    appraiseView.userName.text = model.name;
//    appraiseView.time.text = model.time;
//    [appraiseView.start displayRating:model.score];
//    appraiseView.msg.text = model.content;
//    appraiseView.respond.hidden = !model.status;
//    appraiseView.bg.hidden = !model.status;
//    if (model.status) {
//        appraiseView.shopMsg.text = model.reply_cont;
//        [appraiseView.shopMsg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo((model.icon.count?appraiseView.imgArrM.lastObject:appraiseView.msg).mas_bottom).offset(35);
//            make.left.equalTo(appraiseView.header.mas_centerX).offset(5);
//            make.right.equalTo(appraiseView.mas_right).offset(-15);
//        }];
//    }
//    if (model.icon.count) {
//        @weakify(appraiseView);
//        NSMutableArray<KSPhotoItem *> *items = [NSMutableArray array];
//        [model.icon enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:weak_appraiseView.imgArrM[idx] imageUrl:[NSURL URLWithString:obj]];
//            [items addObject:item];
//            [weak_appraiseView.imgArrM[idx] yy_setImageWithURL:[NSURL URLWithString:obj] options:YYWebImageOptionProgressive];
//            [weak_appraiseView.imgArrM[idx] setUserInteractionEnabled:YES];
//            [weak_appraiseView.imgArrM[idx] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//                KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:idx];
//                [browser showFromViewController:weakSelf];
//            }]];
//        }];
//    }else {
//        [appraiseView.imgArrM enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj removeFromSuperview];
//        }];
//        [appraiseView.imgArrM removeAllObjects];
//    }
//    [cell.contentView addSubview:appraiseView];
//    [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(cell.contentView);
//    }];
//
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.dividingLine = YES;
//
//    return cell;
//    }
    
    
    HEBKTVNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cell3 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中状态颜色为无色
    
    switch (indexPath.row) {
        case 0:
            cell.titlLabel.text = @"有效期";
            cell.contentLabel.text = [NSString stringWithFormat:@"%@至%@",self.groupBuyDetailsModel.f_starttime,self.groupBuyDetailsModel.f_endtime];
            break;
         
        case 1:
            cell.titlLabel.text = @"使用时间";
            cell.contentLabel.text = [NSString stringWithFormat:@"%@-%@",self.groupBuyDetailsModel.f_starttime1,self.groupBuyDetailsModel.f_endtime1];
            break;
        case 2:
            cell.titlLabel.text = @"预约信息";
            cell.contentLabel.text = self.groupBuyDetailsModel.f_bespeak;
            break;
        case 3:
            cell.titlLabel.text = @"适用人群";
            cell.contentLabel.text = self.groupBuyDetailsModel.f_apply;
            break;
        case 4:
            cell.titlLabel.text = @"规则提醒";
            cell.contentLabel.text = self.groupBuyDetailsModel.f_rule;
            break;
        case 5:
            cell.titlLabel.text = @"商家服务";
            cell.contentLabel.text = self.groupBuyDetailsModel.f_seller;
            break;
        case 6:
            cell.titlLabel.text = @"温馨提示";
            cell.contentLabel.text = self.groupBuyDetailsModel.f_cue;
            break;
        default:
            break;
    }
    
    return cell;
}


#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}







#pragma mark-立即预定BtnClik
-(void)rightReserveBtnClik:(UIButton *)sender{
    
    HEBPlaceOrderVC *placeOrderVC = [HEBPlaceOrderVC new];
    [self.navigationController pushViewController:placeOrderVC animated:YES];
   
    
}


@end
