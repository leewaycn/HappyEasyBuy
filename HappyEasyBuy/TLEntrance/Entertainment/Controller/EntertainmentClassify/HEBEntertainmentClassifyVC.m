
//
//  HEBEntertainmentClassifyVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBEntertainmentClassifyVC.h"
#import "HEBTakOutDetailToolsView.h"
#import "HEBEntertainmentistTabViewCell.h"
#import "HEBsorteTableViewCell.h"
#import "HEBEntertainmentDetailsVC.h"
#import "HEBClassificationModel.h"

@interface HEBEntertainmentClassifyVC ()<UITableViewDelegate,UITableViewDataSource>

/** 按钮容器视图 */
@property (nonatomic,weak)UIView *btnContainer;
//* 排序按钮 */
@property (nonatomic,weak)UIButton *sorteBtn;
/** 智能筛选视图 */
@property (nonatomic,weak)UITableView *sorteTableView;
//选择类别视图
@property (nonatomic,weak)UITableView *classBtnTableView;
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

static NSString *cellID1 = @"cellID1";
static NSString *sorteCellID = @"sorteCellID";
static NSString *entertainmentClassCell = @"entertainmentClassCell";
int lsrow = 0;

@implementation HEBEntertainmentClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = UIColorHex(#e7e7e7);
    [self loadClassData];
    [self setupUI];
    
    
}
#pragma mark-//请求分类数据
-(void)loadClassData{
    NSString *url = @"Home/Foods/allClass";
    
    [self.classparams setObject:@"3" forKey:@"cate_id"];
    
    [Networking postUrl:url params:self.classparams callBack:^(id response, MainModel *mainModel, NSError *errorData) {
//        [self loadLeisureListData];
        if ([response[@"status"] integerValue] == 1) {
            
            self.leisureClassArraM = [NSArray yy_modelArrayWithClass:[HEBClassificationModel class] json:mainModel.data];
            
            [self.listparams setValue:self.leisureClassArraM[0].objid forKey:@"cid"];
            
            NSLog(@"%@========%zd",response,self.leisureClassArraM.count);
//            [self setupUI];
        
        }
        
    }];
    
     }


#pragma mark-//请求列表数据
-(void)loadLeisureListData{
    //    休闲娱乐列表参数: jsonObject={"index_page":1,"index_size":10,"lng":118.244739,"lat":35.005517,"cid":12,"city_id":"147"}
    //列表接口
    //http://luntan.guoxiangou.cn/Home/Happy/foot_list
    NSString *url = @"Home/Happy/foot_list";
    
    //需要传入分类参数
    //    [self.listparams setObject:@"" forKey:@"cid"];
    [Networking postUrl:url params:self.listparams callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        self.leisureListArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBLeisureListModel class] json:mainModel.data]];
        //        刷新数据
        
        NSLog(@"%@============%zd",response,self.leisureListArrayM.count);
        
    }];

}

-(void)setupUI{

    UIView *btnContainer = [[UIView alloc]init];
    _btnContainer = btnContainer;
//    添加View顶部和尾部线
    btnContainer.qmui_borderPosition = QMUIBorderViewPositionTop|QMUIBorderViewPositionBottom;
    btnContainer.qmui_borderWidth = 1;
    btnContainer.qmui_borderColor = UIColorHex(#e7e7e7);
    
    btnContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnContainer];
    [btnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
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
    
    /** 分类按钮 */
    UIButton *classBtn = [[UIButton alloc]init];
    [classBtn setTitle:@"全部" forState:UIControlStateNormal];
    classBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [classBtn addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnContainer addSubview:classBtn];
    [classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(btnContainer);
        make.right.equalTo(centerView.mas_left);
        
    }];
    
    /** 排序 */
    UIButton *sorteBtn = [[UIButton alloc]init];
    _sorteBtn = sorteBtn;
    sorteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sorteBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    [sorteBtn addTarget:self action:@selector(sorteClick:) forControlEvents:UIControlEventTouchUpInside];
    [sorteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnContainer addSubview:sorteBtn];
    [sorteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(btnContainer);
        make.left.equalTo(centerView.mas_right);
    }];
    
    //分类视图列表
    UITableView *classTableView = [[UITableView alloc]init];
    classTableView.tag = 3;
    classTableView.dataSource = self;
    classTableView.delegate = self;
    classTableView.backgroundColor = UIColorHex(#e7e7e7);
      //        注册cell
    [classTableView registerClass:[HEBEntertainmentistTabViewCell class] forCellReuseIdentifier:entertainmentClassCell];
    
    [self.view addSubview:classTableView];
    [classTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(btnContainer.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark分类按钮事件
-(void)classBtnClick:(UIButton *)sentr{
    
    NSLog(@"点击了分类按钮");
    if(_classBtnTableView == nil){
    UITableView *classBtnTableView = [[UITableView alloc]init];
    _classBtnTableView = classBtnTableView;
        [classBtnTableView registerClass:[HEBsorteTableViewCell class] forCellReuseIdentifier:cellID1];
        classBtnTableView.delegate = self;
        classBtnTableView.dataSource = self;
    classBtnTableView.backgroundColor = UIColorHex(#e7e7e7);
        classBtnTableView.tag = 1;
    [self.view addSubview:classBtnTableView];
    [classBtnTableView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(_btnContainer.mas_bottom);
        make.height.mas_offset(120);
        
    }];
        
        [_sorteTableView removeFromSuperview];
    }else{
        
        [_classBtnTableView removeFromSuperview];
    }
        
}

#pragma mark-排序按钮事件
-(void)sorteClick:(UIButton *)senter{

    NSLog(@"点击了排序按钮");
    if (_sorteTableView == nil) {
        UITableView *sorteTableView = [[UITableView alloc]init];
        sorteTableView.dataSource = self;
        sorteTableView.delegate = self;
        //    注册排序cell
        [sorteTableView registerClass:[HEBsorteTableViewCell class] forCellReuseIdentifier:sorteCellID];
        sorteTableView.tag = 2;
        sorteTableView.backgroundColor = UIColorHex(#e7e7e7);

        _sorteTableView = sorteTableView;

        [self.view addSubview:sorteTableView];
        [sorteTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(_btnContainer.mas_bottom).offset(1);
            make.height.mas_equalTo(120);
        }];
        [_classBtnTableView removeFromSuperview];
    }else{
        
        [_sorteTableView removeFromSuperview];
    }
    
    
    
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1) {
        
//        return 3;
        return self.leisureClassArraM.count;
    }
//    if (tableView.tag == 3) {
//        return self.leisureListArrayM.count;
//    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        
        NSArray *classBtnList = @[@"测试休闲娱乐列表1",@"休闲娱乐2",@"休闲娱乐3",@"娱乐4"];

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1" forIndexPath:indexPath];
//        cell.textLabel.text = classBtnList[indexPath.row];
        
        cell.textLabel.text = self.leisureClassArraM[indexPath.row].name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  
        return cell;
    }else if (tableView.tag == 2){
        NSArray *sortBtnList = @[@"价格最低",@"距离最近"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sorteCellID" forIndexPath:indexPath];
        
        cell.textLabel.text = sortBtnList[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    //休闲娱乐列表cell
    HEBEntertainmentistTabViewCell *entertainmentClassCell = [tableView dequeueReusableCellWithIdentifier:@"entertainmentClassCell" forIndexPath:indexPath];
    entertainmentClassCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return entertainmentClassCell;
}


#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 3) {
        return 80;
    }
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        NSLog(@"点击分类cell");
//        发送网络请求
        
    }
    if (tableView.tag == 2) {
        NSLog(@"点击排序cell");
        //发送网络请求
        
    }
    if (tableView.tag == 3) {
        HEBEntertainmentDetailsVC *entertainmentDetailsVC = [[HEBEntertainmentDetailsVC alloc]init];
//        需要传入ha_id
        
        [self.navigationController pushViewController:entertainmentDetailsVC animated:YES];
        
    }
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationItem.title = @"分类";
    
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



@end
