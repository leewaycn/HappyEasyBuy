//
//  HEBContactUsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/5.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
#define FontSize 14

#import "HEBContactUsVC.h"
#import "HEBContactUsCell.h"
#import "HEBContaactUsModel.h"

@interface HEBContactUsVC ()
//模型
@property(nonatomic, strong)HEBContaactUsModel *usModel;
//us列表
@property(nonatomic, weak) UITableView *contactUsTableView;

//模型数组
@property(nonatomic, strong)NSMutableArray <HEBContaactUsModel *>*usArrayM;
//咨询热线
@property(nonatomic, copy)UILabel *hotline;
//联系人
@property(nonatomic, weak)UILabel *contacts;



@end

static NSString *cellID = @"cellID";

@implementation HEBContactUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self loadData];
   
}

-(void)loadData{
    
//    http://luntan.guoxiangou.cn/Home/Company/contactUs
    NSString *url = @"Home/Company/contactUs";

    [Networking postUrl:url params:@{@"id":@"1"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        
        HEBContaactUsModel *usModel = [HEBContaactUsModel yy_modelWithJSON:mainModel.data];
        _usModel = usModel;
//
//        self.usArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBContaactUsModel class] json:mainModel.data]];
        
         [self setupUI];
        
    }];
    
}


-(void)setupUI{
    
//    UITableView *contactUsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
//    _contactUsTableView = contactUsTableView;
//    咨询热线
    UIView *hotlineView = [UIView new];
    hotlineView.backgroundColor = [UIColor orangeColor];
    hotlineView.layer.cornerRadius = 8;
    hotlineView.layer.masksToBounds = YES;
    [self.view addSubview:hotlineView];
    [hotlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(20);
        make.width.height.mas_offset(10);
    }];
   
    UILabel *hotlineTitl = [UILabel new];
    hotlineTitl.font = [UIFont systemFontOfSize:FontSize];
    hotlineTitl.text = @"咨询热线:";
    [self.view addSubview:hotlineTitl];
    [hotlineTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineView.mas_right).offset(5);
        make.centerY.equalTo(hotlineView);
    }];
    
    UILabel *hotline = [UILabel new];
    _hotline = hotline;
    hotline.font = [UIFont systemFontOfSize:FontSize];
    hotline.text = self.usModel.hotline;
    hotline.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:hotline];
    [hotline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineTitl.mas_right).offset(5);
        make.centerY.equalTo(hotlineTitl);
        
    }];
//    联系人
    UIView *contactsView = [UIView new];
    contactsView.backgroundColor = [UIColor orangeColor];
    contactsView.layer.cornerRadius = 8;
    contactsView.layer.masksToBounds = YES;
    [self.view addSubview:contactsView];
    [contactsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineView);
        make.top.equalTo(hotlineView.mas_bottom).offset(20);
        make.width.height.mas_equalTo(hotlineView);
    }];
    
    UILabel *contactsTitl = [UILabel new];
    contactsTitl.font = [UIFont systemFontOfSize:FontSize];
    contactsTitl.text = @"联系人: ";
    [self.view addSubview:contactsTitl];
    [contactsTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineTitl);
        make.centerY.equalTo(contactsView);
    }];
    
     UILabel *contacts = [UILabel new];
    _contacts = contacts;
    contacts.font = [UIFont systemFontOfSize:FontSize];
    contacts.text = self.usModel.contacts;
    contacts.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:contacts];
    [contacts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotline);
        make.centerY.equalTo(contactsView);
    }];
//    手机
    UIView *phoneView = [UIView new];
    phoneView.backgroundColor = [UIColor orangeColor];
    phoneView.layer.cornerRadius = 8;
    phoneView.layer.masksToBounds = YES;
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contactsView);
        make.top.equalTo(contactsView.mas_bottom).offset(20);
        make.width.height.mas_equalTo(10);
    }];

    UILabel *phoneTitl = [UILabel new];
    phoneTitl.font = [UIFont systemFontOfSize:FontSize];
    phoneTitl.text = @"手机:";
    [self.view addSubview:phoneTitl];
    [phoneTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineTitl);
        make.centerY.equalTo(phoneView);
    }];

    UILabel *phoneLabel = [UILabel new];
//    _phoneLabel = phoneLabel;
    phoneLabel.font = [UIFont systemFontOfSize:FontSize];
    phoneLabel.text = self.usModel.phone;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotline);
        make.centerY.equalTo(phoneView);
    }];
//    电话

        UIView *telephoneView = [UIView new];
        telephoneView.backgroundColor = [UIColor orangeColor];
        telephoneView.layer.cornerRadius = 8;
        telephoneView.layer.masksToBounds = YES;
        [self.view addSubview:telephoneView];
        [telephoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneView);
            make.top.equalTo(phoneView.mas_bottom).offset(20);
            make.width.height.mas_equalTo(phoneView);
        }];

        UILabel *telephoneTitl = [UILabel new];
        telephoneTitl.font = [UIFont systemFontOfSize:FontSize];
        telephoneTitl.text = @"电话:";
        [self.view addSubview:telephoneTitl];
        [telephoneTitl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(hotlineTitl);
            make.centerY.equalTo(telephoneView);
        }];

        UILabel *telephone = [UILabel new];
        //    _phoneLabel = phoneLabel;
        telephone.font = [UIFont systemFontOfSize:FontSize];
        telephone.text = self.usModel.tel;
        telephone.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:telephone];
        [telephone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(hotline);
            make.centerY.equalTo(telephoneView);
             }] ;
//
//    邮箱
    UIView *emailView = [UIView new];
    emailView.backgroundColor = [UIColor orangeColor];
    emailView.layer.cornerRadius = 8;
    emailView.layer.masksToBounds = YES;
    [self.view addSubview:emailView];
    [emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(telephoneView);
        make.top.equalTo(telephoneView.mas_bottom).offset(20);
        make.width.height.mas_equalTo(telephoneView);
    }];

    UILabel *emaiTitl = [UILabel new];
    emaiTitl.font = [UIFont systemFontOfSize:FontSize];
    emaiTitl.text = @"邮箱:";
    [self.view addSubview:emaiTitl];
    [emaiTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineTitl);
        make.centerY.equalTo(emailView);
    }];

    UILabel *emai = [UILabel new];
    //    _phoneLabel = phoneLabel;
    emai.font = [UIFont systemFontOfSize:FontSize];
    emai.text = self.usModel.email;
    emai.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:emai];
    [emai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotline);
        make.centerY.equalTo(emailView);
    }] ;
    
//    地址
    UIView *addressView = [UIView new];
    addressView.backgroundColor = [UIColor orangeColor];
    addressView.layer.cornerRadius = 8;
    addressView.layer.masksToBounds = YES;
    [self.view addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(emailView);
        make.top.equalTo(emailView.mas_bottom).offset(20);
        make.width.height.mas_equalTo(emailView);
    }];
    
    UILabel *addressTitl = [UILabel new];
    addressTitl.font = [UIFont systemFontOfSize:FontSize];
    addressTitl.text = @"地址:";
    [self.view addSubview:addressTitl];
    [addressTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineTitl);
        make.centerY.equalTo(addressView);
    }];
    
    UILabel *address = [UILabel new];
    //    _phoneLabel = phoneLabel;
    address.font = [UIFont systemFontOfSize:FontSize];
    address.text = self.usModel.address;
    address.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotline);
        make.centerY.equalTo(addressView);
    }] ;

}

#pragma mark- UITableViewDataSource 数据源
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 6;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HEBContactUsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//    cell.usModel = self.usModel;
//
//    return cell;
//}


@end
