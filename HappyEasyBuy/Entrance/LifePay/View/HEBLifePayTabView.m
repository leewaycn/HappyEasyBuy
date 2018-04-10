//
//  HEBLifePayTabView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLifePayTabView.h"

#import "LWGroupItem.h"
#import "LWSettingItem.h"

#import "HEBGasCardViewController.h"

@interface HEBLifePayTabView ()<QMUITableViewDelegate, QMUITableViewDataSource>

//当前界面的数据源 用来存储分组模型
@property (nonatomic ,strong) NSMutableArray *groupArray;

@end

@implementation HEBLifePayTabView

#pragma MARK - 懒加载
- (NSMutableArray *)groupArray
{
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

#pragma mark - UI
- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    [self group1];
}
#pragma MARK - 条目分组
- (void)group1
{
    LWGroupItem *group0 = [[LWGroupItem alloc] init];
    LWSettingItem *item = [LWSettingItem itemWithTitle:@"话费充值" icon:@"huafeichongzhi" rigthTitle:nil];
    LWSettingItem *item1 = [LWSettingItem itemWithTitle:@"加油卡充值" icon:@"jiayoukachongzhi"rigthTitle:nil];
    LWSettingItem *item2 = [LWSettingItem itemWithTitle:@"违章查询" icon:@"weizhangchaxun"rigthTitle:nil];
    LWSettingItem *item3 = [LWSettingItem itemWithTitle:@"流量充值" icon:@"liouliangchongzhi"rigthTitle:nil];
    
    group0.itemsArray = @[item,item1,item2,item3];
    
    [self.groupArray addObject:group0];
}
#pragma mark - tab的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LWGroupItem *group = self.groupArray[section];
    return group.itemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    LWGroupItem *group = self.groupArray[indexPath.section];
    LWSettingItem *item = group.itemsArray[indexPath.row];
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed:item.icon];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    switch (indexPath.row) {
        case 0:
            NSLog(@"点击了话费充值");
            break;
        case 1:
            
        {
            HEBGasCardViewController *gasCardVc = [HEBGasCardViewController new];
            [self.viewController.navigationController pushViewController:gasCardVc animated:YES];
            
        }
            break;
        case 2:
            NSLog(@"违章查询");
            break;
        case 3:
            NSLog(@"流量充值");
            
        default:
            break;
    }
}
@end
