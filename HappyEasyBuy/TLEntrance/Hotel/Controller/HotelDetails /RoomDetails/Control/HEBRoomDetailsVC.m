//
//  HEBRoomDetailsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#define TextFont 12
#import "HEBRoomDetailsVC.h"
#import "HEBCycleScrollView.h"
#import "HEBRoomDetailsModel.h"
#import "HEBRoomCommentModel.h"
#import "HEBPackageDetailsAppraiseModel.h"
#import "HEBPackageDetailsAppraiseView.h"
#import <KSPhotoBrowser.h>
#import "HEBReserveVC.h"
#import "HEBHotelAllcommentsVC.h"

@interface HEBRoomDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
//请求参数
@property(nonatomic, strong)NSMutableDictionary *params;
//头部视图版块
@property(weak, nonatomic)UIView *topbasView;
//轮播图
@property(strong, nonatomic) HEBCycleScrollView *cyView;
//规则视图版块
@property(weak, nonatomic)UIView *roomDataView;

//房间信息模型
@property(nonatomic, strong)HEBRoomDetailsModel *roomDetailsModel;
////评论模型
//@property(nonatomic, strong)HEBPackageDetailsAppraiseModel *AppraiseModel;
//评论模型数组
@property(nonatomic, strong)NSMutableArray <HEBPackageDetailsAppraiseModel *>*roomCommentArrayM;

//上网类型
@property(weak, nonatomic)UILabel *netPlay;
//是否有窗户
@property(weak, nonatomic)UILabel *windowLabel;
//床性
@property(weak, nonatomic)UILabel *bedLabel;
//卫浴
@property(weak, nonatomic)UILabel *bathroom;
//可住人数
@property(weak, nonatomic)UILabel *toLive;
//早餐
@property(weak, nonatomic)UILabel *breakfast;
//使用规则
@property(weak, nonatomic)UILabel *ruleLabel;
//价格
@property(weak, nonatomic)UIButton *leftMoneyBtn;
@property(weak, nonatomic)UITableView *roomTableView;


@end

NSString *cellID = @"cellID";

@implementation HEBRoomDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self loadRoomDetailsData];
    [self setupUI];
}

#pragma mark_评论接口数据请求
-(void)loadCommentData{
//http://luntan.guoxiangou.cn/Home/Room/hotelRemark

    NSString *url = @"Home/Room/hotelRemark";
    [Networking postUrl:url params:@{@"tcid":self.rid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
       
        self.roomCommentArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];

//            NSLog(@"%@--------%zd",response,self.roomCommentArrayM.count );
        [self.roomTableView reloadData];
    }];
}

#pragma mark 房间信息请求接口数据
-(void)loadRoomDetailsData{
//    http://luntan.guoxiangou.cn/Home/Room/hotel_room_info
    NSString *url = @"Home/Room/hotel_room_info";
   
    [Networking postUrl:url params:@{@"r_id":self.rid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
         HEBRoomDetailsModel *roomDetailsModel = [HEBRoomDetailsModel yy_modelWithJSON:mainModel.data];
        _roomDetailsModel = roomDetailsModel;
        
        if (!errorData) {
            [self loadCommentData];
        }
        
        if (self.roomDetailsModel.r_internet == 0) {
            self.netPlay.text = @"wifi";
        }else{
            self.netPlay.text = @"无";
        }
        if (self.roomDetailsModel.r_window == 1) {
                self.windowLabel.text = @"无窗户";
        }else{
            self.windowLabel.text = @"有窗户";
        }
        if (self.roomDetailsModel.r_bathroom == 1) {
            self.bathroom.text = @"不独立";
        }else{
            self.bathroom.text = @"独立";
        }
        if(self.roomDetailsModel.r_breakfast == 1){
            self.breakfast.text = @"不含早餐";
        }else{
            self.breakfast.text = @"含早餐";
        }
        self.bedLabel.text = self.roomDetailsModel.r_bed;
        self.toLive.text = self.roomDetailsModel.r_number;
        self.ruleLabel.text = self.roomDetailsModel.r_rule;
        [self.leftMoneyBtn setTitle:[NSString stringWithFormat:@"￥%@",self.roomDetailsModel.r_price]  forState:UIControlStateNormal];
    
    }];
}

#pragma mark-搭建UI
-(void)setupUI{

//** TableView容器视图 */
    UITableView *roomTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-50) style:UITableViewStyleGrouped];
    selfClass(roomTableView);
    [self.view addSubview:roomTableView];
    //    注册cell
    [roomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    roomTableView.dataSource = self;
    roomTableView.delegate = self;
//**  头部容器视图 */
    UIView *topbasView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 280)];
    _topbasView = topbasView;
    topbasView.backgroundColor = UIColorHex(#f1f1f1);
//    把头部视图添加到表头视图
    roomTableView.tableHeaderView = topbasView;
    
//** 轮播图  */
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 120*SCREEN_WIDTH/375)];
    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"4"];
    [topbasView addSubview:cyView];
    [self addRoomDataView];
    [self addRuleView];
    
//    金额
    UIButton *leftMoneyBtn = [UIButton new];
    _leftMoneyBtn = leftMoneyBtn;
    [leftMoneyBtn setTitle:@"￥" forState:UIControlStateNormal];
    [leftMoneyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    leftMoneyBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftMoneyBtn];
    [leftMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
//    预定按钮
    UIButton *rightReserveBtn = [UIButton new];
    [rightReserveBtn setTitle:@"预定" forState:UIControlStateNormal];
    [rightReserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightReserveBtn.backgroundColor = [UIColor orangeColor];
    [rightReserveBtn addTarget:self action:@selector(rightReserveBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightReserveBtn];
    [rightReserveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(50);
        
    }];
}

#pragma mark//房间资料View
-(void)addRoomDataView{
    UIView *roomDataView = [UIView new];
    _roomDataView = roomDataView;
    roomDataView.bottomLine = YES;
    roomDataView.backgroundColor = [UIColor whiteColor];
    [_topbasView addSubview:roomDataView];
    [roomDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.topbasView);
        
        make.top.equalTo(_cyView.mas_bottom);
        make.height.mas_offset(90);
    }];
//    上网
    UILabel *netPlayTitle = [UILabel new];
    netPlayTitle.text = @"上网";
    netPlayTitle.textColor = [UIColor grayColor];
    netPlayTitle.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:netPlayTitle];
    [netPlayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomDataView).offset(10);
        make.top.equalTo(roomDataView).offset(10);
    }];
//    上网类型
    UILabel *netPlay = [UILabel new];
    _netPlay = netPlay;
//    netPlay.text = @"wifi-";
    netPlay.textColor = [UIColor blackColor];
    netPlay.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:netPlay];
    [netPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(netPlayTitle.mas_right).offset(10);
        make.centerY.equalTo(netPlayTitle);
    }];
    
    
//    窗户
    UILabel *windowTitle = [UILabel new];
    windowTitle.text = @"窗户";
    windowTitle.textColor = [UIColor grayColor];
    windowTitle.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:windowTitle];
    [windowTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomDataView).offset(10);
        make.top.equalTo(netPlayTitle.mas_bottom).offset(10);
    }];
    
    UILabel *windowLabel = [UILabel new];
    _windowLabel = windowLabel;
//    windowLabel.text = @"有窗户-";
    windowLabel.textColor = [UIColor blackColor];
    windowLabel.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:windowLabel];
    [windowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(windowTitle.mas_right).offset(10);
        make.centerY.equalTo(windowTitle);
    }];
    
//    床型
    UILabel *bedTitle = [UILabel new];
    bedTitle.text = @"床型";
    bedTitle.textColor = [UIColor grayColor];
    bedTitle.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:bedTitle];
    [bedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(windowTitle);
        make.top.equalTo(windowTitle.mas_bottom).offset(10);
    }];

    UILabel *bedLabel = [UILabel new];
    _bedLabel = bedLabel;
//    bedLabel.text = @"大床，2.2米的-";
    bedLabel.textColor = [UIColor blackColor];
    bedLabel.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:bedLabel];
    [bedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bedTitle.mas_right).offset(10);
        make.centerY.equalTo(bedTitle);
    }];

    
//    卫浴
    UILabel *bathroomTite = [UILabel new];
    bathroomTite.text = @"卫浴";
    bathroomTite.textColor = [UIColor grayColor];
    bathroomTite.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:bathroomTite];
    [bathroomTite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomDataView.mas_centerX).offset(40);
        make.top.equalTo(roomDataView).offset(10);
    }];
  
    UILabel *bathroom = [UILabel new];
    _bathroom = bathroom;
//    bathroom.text = @"独立卫浴-";
    bathroom.textColor = [UIColor blackColor];
    bathroom.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:bathroom];
    [bathroom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bathroomTite.mas_right).offset(10);
        make.centerY.equalTo(bathroomTite.mas_centerY);
    }];
    
//    可住
    UILabel *toLiveTite = [UILabel new];
    toLiveTite.text = @"可住";
    toLiveTite.textColor = [UIColor grayColor];
    toLiveTite.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:toLiveTite];
    [toLiveTite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bathroomTite);
        make.top.equalTo(bathroomTite.mas_bottom).offset(10);
    }];

    UILabel *toLive = [UILabel new];
    _toLive = toLive;
//    toLive.text = @"2-";
    toLive.textColor = [UIColor blackColor];
    toLive.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:toLive];
    [toLive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toLiveTite.mas_right).offset(10);
        make.centerY.equalTo(toLiveTite.mas_centerY);
    }];
    
    
    // 早餐
    UILabel *breakfastTite = [UILabel new];
    breakfastTite.text = @"早餐";
    breakfastTite.textColor = [UIColor grayColor];
    breakfastTite.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:breakfastTite];
    [breakfastTite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toLiveTite);
        make.top.equalTo(toLiveTite.mas_bottom).offset(10);
    }];
    
    UILabel *breakfast = [UILabel new];
    _breakfast = breakfast;
//    breakfast.text = @"有没有早餐-";
    breakfast.textColor = [UIColor blackColor];
    breakfast.font = [UIFont systemFontOfSize:TextFont];
    [roomDataView addSubview:breakfast];
    [breakfast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(breakfastTite.mas_right).offset(10);
        make.centerY.equalTo(breakfastTite.mas_centerY);
    }];
    
}

-(void)addRuleView{
    
    UIView *ruleView = [[UIView alloc]init];
    ruleView.backgroundColor = [UIColor whiteColor];
    [self.topbasView addSubview:ruleView];
    [ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.topbasView);
        make.height.mas_offset(60);
        make.top.equalTo(self.roomDataView.mas_bottom).offset(5);
    }];
//
    UILabel *ruleTite = [UILabel new];
    ruleTite.text = @"使用规则";
    ruleTite.font = [UIFont systemFontOfSize:14];
    [ruleView addSubview:ruleTite];
    [ruleTite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ruleView).offset(10);
    }];
    
    UILabel *ruleLabel = [UILabel new];
    _ruleLabel = ruleLabel;
//    ruleLabel.text = @"直接消费,无需排队,请携带入住身份证-";
    ruleLabel.textColor = [UIColor grayColor];
    ruleLabel.font = [UIFont systemFontOfSize:TextFont];
    [ruleView addSubview:ruleLabel];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ruleTite);
        make.top.equalTo(ruleTite.mas_bottom).offset(10);
        
    }];
}


#pragma mark-UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HEBPackageDetailsAppraiseModel *model = self.roomCommentArrayM[indexPath.row];
    return model.content.heightWith14_90+70+(model.icon.count?(SCREEN_WIDTH/6):0)+(model.status?(60+model.reply_cont.heightWith14_90):0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *FooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.roomTableView.width, 40)];
    FooterView.backgroundColor = [UIColor whiteColor];
    UIButton *wholeButton = [[UIButton alloc]init];
    [wholeButton setTitle:@"查看全部" forState:UIControlStateNormal];
    [wholeButton addTarget:self action:@selector(wholeButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    [wholeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [FooterView addSubview:wholeButton];
    [wholeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(FooterView);
    }];
    
    return FooterView;
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.roomCommentArrayM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    __weak typeof(self)weakSelf = self;
    HEBPackageDetailsAppraiseModel *model = self.roomCommentArrayM[indexPath.row];
    HEBPackageDetailsAppraiseView *appraiseView = [[HEBPackageDetailsAppraiseView alloc] init];
    [appraiseView.header yy_setImageWithURL:[NSURL URLWithString:model.headimg] options:YYWebImageOptionProgressive];
    appraiseView.userName.text = model.name;
    appraiseView.time.text = model.time;
    [appraiseView.start displayRating:model.score];
    appraiseView.msg.text = model.content;
    appraiseView.respond.hidden = !model.status;
    appraiseView.bg.hidden = !model.status;
    if (model.status) {
        appraiseView.shopMsg.text = model.reply_cont;
        [appraiseView.shopMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo((model.icon.count?appraiseView.imgArrM.lastObject:appraiseView.msg).mas_bottom).offset(35);
            make.left.equalTo(appraiseView.header.mas_centerX).offset(5);
            make.right.equalTo(appraiseView.mas_right).offset(-15);
        }];
    }
    if (model.icon.count) {
        @weakify(appraiseView);
        NSMutableArray<KSPhotoItem *> *items = [NSMutableArray array];
        [model.icon enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:weak_appraiseView.imgArrM[idx] imageUrl:[NSURL URLWithString:obj]];
            [items addObject:item];
            [weak_appraiseView.imgArrM[idx] yy_setImageWithURL:[NSURL URLWithString:obj] options:YYWebImageOptionProgressive];
            [weak_appraiseView.imgArrM[idx] setUserInteractionEnabled:YES];
            [weak_appraiseView.imgArrM[idx] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:idx];
                [browser showFromViewController:weakSelf];
            }]];
        }];
    }else {
        [appraiseView.imgArrM enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [appraiseView.imgArrM removeAllObjects];
    }
    [cell.contentView addSubview:appraiseView];
    [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dividingLine = YES;

    return cell;
    }


#pragma mark_ 预定按钮点击事件
-(void)rightReserveBtnClik:(UIButton *)sender{
    NSLog(@"点击预定");
    HEBReserveVC *reserveVC = [[HEBReserveVC alloc]init];
    [self.navigationController pushViewController:reserveVC animated:YES];
    reserveVC.r_id = self.rid;
    reserveVC.h_id = self.hid;
//    reserveVC.shopid = 
}

#pragma mark-wholeButton查看全部按钮点击事件
-(void)wholeButtonClik:(UIButton *)sender{
    NSLog(@"查看全部");
    HEBHotelAllcommentsVC *lAllcommentsVc = [HEBHotelAllcommentsVC new];
    lAllcommentsVc.rid = self.rid;
    [self.navigationController pushViewController:lAllcommentsVc animated:YES ];
}

#pragma mark- 请求参数
-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}
@end
