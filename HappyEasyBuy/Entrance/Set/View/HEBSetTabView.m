//
//  HEBSetTabView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBSetTabView.h"
#import "HEBWKWebViewController.h"
#import "HEBFeedbackViewController.h"

@interface HEBSetTabView ()<QMUITableViewDelegate, QMUITableViewDataSource>

//当前界面的数据源 用来存储分组模型
@property (nonatomic ,strong) NSArray<NSString *> *settingModelArr;

@end

@implementation HEBSetTabView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    self.backgroundColor = UIColorHex(#f1f1f1);
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableFooterView = foot;
    QMUIButton *logout = [[QMUIButton alloc] init];
    selfClass(logout);
    logout.hidden = !getUser_id;
    logout.backgroundColor = BASECOLOR;
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    [logout setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [foot addSubview:logout];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(foot.mas_top).offset(25);
        make.left.equalTo(foot.mas_left).offset(25);
        make.right.equalTo(foot.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
    logout.layer.cornerRadius = 5;
    logout.layer.masksToBounds = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dividingLine = YES;
    cell.textLabel.text = self.settingModelArr[indexPath.row];
    if ([self.settingModelArr[indexPath.row] isEqualToString:@"清除缓存"]) {
        NSString *sizeCache = @"暂无缓存";
        long long Cache = [DWNetworking getCachesSize];
        NSLog(@"%lld", Cache);
        if (Cache/1024/1024 > 0) {
            sizeCache = [NSString stringWithFormat:@"%lld G", Cache/1024/1024];
        }else if (Cache/1024 > 0) {
            sizeCache = [NSString stringWithFormat:@"%lld M", Cache/1024];
        }else if (Cache > 0) {
            sizeCache = [NSString stringWithFormat:@"%lld K", Cache];
        }
        cell.detailTextLabel.text = sizeCache;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    switch (indexPath.row) {
        case 0:{
            HEBWKWebViewController *serviceVc = [[HEBWKWebViewController alloc] init];
            serviceVc.url = @"Home/Artical/info";
            serviceVc.title = @"服务协议";
            [self.viewController.navigationController pushViewController:serviceVc animated:YES];
        }
            break;
        case 1:{
            HEBFeedbackViewController *feedBackVc = [[HEBFeedbackViewController alloc] init];
            feedBackVc.title = @"求助反馈";
            [self.viewController.navigationController pushViewController:feedBackVc animated:YES];
        }
            break;
        case 2:;{
            [self.viewControl.progressHUD showAnimated:YES];
            [DWNetworking cleanAllCache];
            [self.viewControl.progressHUD hideAnimated:YES afterDelay:1.25];
            [tableView reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }break;
        case 3:{
            HEBWKWebViewController *aboutUs = [[HEBWKWebViewController alloc] init];
            aboutUs.url = @"Home/Artical/about";
            aboutUs.title = @"关于我们";
            [self.viewController.navigationController pushViewController:aboutUs animated:YES];
        }
        default:
            break;
    }
    
}

- (NSArray<NSString *> *)settingModelArr {
    if (!_settingModelArr) {
        _settingModelArr = @[@"服务协议", @"求助反馈", @"清除缓存", @"关于"];
    }
    return _settingModelArr;
}

@end
