//
//  HEBCompanyHomePageVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/5.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBCompanyHomePageVC.h"
#import "HEBCompanyHomePageModel.h"
@interface HEBCompanyHomePageVC ()

@property(nonatomic, strong)HEBCompanyHomePageModel *companyHomePageModel;


@end

@implementation HEBCompanyHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self loadData];
    
}



-(void)loadData{
//    http://luntan.guoxiangou.cn/Home/Company/index
    NSString *url = @"Home/Company/index";
//      [_params setObject:getLon forKey:@"lng"];
    
    [Networking postUrl:url params:@{@"id":@"1"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        NSLog(@"%@",response);
        
        HEBCompanyHomePageModel *companyHomePageModel = [HEBCompanyHomePageModel yy_modelWithJSON:mainModel.data];
        _companyHomePageModel = companyHomePageModel;
        NSLog(@"%@",_companyHomePageModel.infourl);
        [self setupUI];
    } ];
}


-(void)setupUI{
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, self.view.height)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.companyHomePageModel.infourl]];

//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    [self.view addSubview: webView];
    [webView loadRequest:request];
    
}
@end
