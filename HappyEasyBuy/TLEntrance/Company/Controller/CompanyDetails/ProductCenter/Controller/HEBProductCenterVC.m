
//
//  HEBProductCenterVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/5.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBProductCenterVC.h"
#import "HEBCompanyRightCell.h"
#import "HEBProductDetailsVC.h"
@interface HEBProductCenterVC ()<UITableViewDelegate,UITableViewDataSource>
//分类模型数组
@property(nonatomic, strong)NSMutableArray *cateListArrayM;
//产品列表模型数组
@property(nonatomic, strong)NSMutableArray *productlistArrayM;


@end

//static NSString *leftCellID = @"leftCellID";
static NSString *rightCellID = @"rightCellID";

@implementation HEBProductCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    
    [self setupUI];
    [self loadCateListNetworking];
    [self loadProductListNetworking];
}


-(void)loadCateListNetworking{
//    http://luntan.guoxiangou.cn/Home/Company/cateList
    //分类接口 shopid
    //       public static final String Getgongsicate = TUrl + "/Home/Company/cateList";//获取公司产品的分类
    NSString *url = @"Home/Company/cateList";
    [Networking postUrl:url params:@{@"1":@"shopid"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
       
        
        
        
        NSLog(@"%@+1",response);
        
        
    }];
    
}


-(void)loadProductListNetworking{
    
//列表接口
//http://luntan.guoxiangou.cn/Home/Company/Productlist
    //    index_page
    //    当前页
    //    cid
    //    分类ID
    //    shopid
    //    店铺ID
    NSString *url = @"Home/Company/Productlist";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"index_page"];
    [params setObject:@"1" forKey:@"cid"];
    [params setObject:@"1" forKey:@"shopid"];
    
    [Networking postUrl:url params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
       
        NSLog(@"%@+2",response);
    }];
    
}


-(void)setupUI{
    UITableView *leftTablView = [UITableView new];
    leftTablView.delegate = self;
    leftTablView.dataSource = self;
    leftTablView.tag = 1;
    leftTablView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:leftTablView];
    [leftTablView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_offset(self.view.width/4);
        
    }];
    
    UITableView *rightTableView = [UITableView new];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.tag = 2;
    rightTableView.backgroundColor = [UIColor greenColor];
//    注册cell
    [rightTableView registerClass:[HEBCompanyRightCell class] forCellReuseIdentifier:rightCellID];
    
    [self.view addSubview:rightTableView];
    [rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.view);
        make.left.equalTo(leftTablView.mas_right);
    }];
}

#pragma mark-UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2) {
//        跳转到产品详情VC
        HEBProductDetailsVC *productDetailsVC = [HEBProductDetailsVC new];
        
        [self.navigationController pushViewController:productDetailsVC animated:YES];
    }
}

#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        
        
        
        
        UITableViewCell *leftCell = [[UITableViewCell alloc]init];
        leftCell.textLabel.font = [UIFont systemFontOfSize:14];
        leftCell.textLabel.text = @"H5页面";
        //cell选中颜色无色
//        leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
        leftCell.textLabel.numberOfLines = 0;
        return leftCell;
    }
    
    HEBCompanyRightCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightCellID forIndexPath:indexPath];
    
    
    return rightCell;
}


////接口参数
//-(NSMutableDictionary *)params{
//    if (!_parms) {
//        [_params setObject:getLat forKey:@"lat"];
//    }
//
//    return _pasams;
//}

@end
