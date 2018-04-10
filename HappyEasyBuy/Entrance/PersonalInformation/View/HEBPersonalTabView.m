//
//  HEBPersonalTabView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPersonalTabView.h"
#import <TZImagePickerController.h>
#import "HEBEditUserINFOViewController.h"

@interface HEBPersonalTabView ()<QMUITableViewDelegate, QMUITableViewDataSource>

//当前界面的数据源 用来存储分组模型
@property (nonatomic ,strong) NSArray<NSArray <NSString *>*> *cellModelArr;

@property(nonatomic, strong) UIImageView *icon;

@end

@implementation HEBPersonalTabView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.dividingLine = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.cellModelArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIImageView *icon = [[UIImageView alloc] init];
            selfClass(icon);
            [cell.contentView addSubview:icon];
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).offset(-10);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.size.equalTo(cell.contentView.mas_height).offset(-15);
            }];
            [icon yy_setImageWithURL:[NSURL URLWithString:@"header".getUserDefaultsINFO] options:YYWebImageOptionProgressive];
            [icon layoutIfNeeded];
            icon.layer.cornerRadius = icon.height/2;
            icon.layer.masksToBounds = YES;
        }else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [getUser_phone encryptMobNumber];
        }else if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"nickName".getUserDefaultsINFO;
        }
    }else {
        if (indexPath.row == 0) {
            NSMutableString *str = [NSMutableString string];
            for (int i = 0; i < [[getUser_passWord decryptAESString] length]; i ++) {
                [str appendString:@"*"];
            }
            cell.detailTextLabel.text = str;
        }
    }
    return cell;
}

- (void)tableView:(QMUITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self editHeaderIMG:tableView];
        }else if (indexPath.row == 1) {
            [self editUserPhone:tableView];
        }else if (indexPath.row == 2) {
            [self editNickName:tableView];
        }
    }else {
        if (indexPath.row == 0) {
            [self editPassWord:tableView];
        }else if (indexPath.row == 1) {
            [self editPayPassword:tableView];
        }else {
            [self forgetPayPassword:tableView];
        }
    }
}

- (void)editHeaderIMG:(UITableView *)tableView {
     __weak __typeof(self)weakSelf = self;
    TZImagePickerController *tzImagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    tzImagePicker.sortAscendingByModificationDate = NO;
    [tzImagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [((HEBBaseViewController *)weakSelf.viewController).progressHUD showAnimated:YES];
        [photos.lastObject uploadIMGWithCallBack:^(id response, NSString *urlString, NSError *errorData) {
            if (urlString) {
                NSString *headerUrl = urlString;
                [Networking postUrl:EditUserPhoto params:@{@"id":getUser_id, @"headimgurl":urlString} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [((HEBBaseViewController *)weakSelf.viewController) dismissProgressHUD];
                    if (mainModel.status) {
                        [Tools toolsUserDefaultsSaveOBJ:headerUrl forKey:@"header"];
                        if (weakSelf.UserHeaderChange) {
                            weakSelf.UserHeaderChange(photos.lastObject);
                        }
                        weakSelf.icon.image = photos.lastObject;
                    }
                }];
            }
        }];
    }];
    [self.viewController presentViewController:tzImagePicker animated:YES completion:nil];
}

- (void)editUserPhone:(QMUITableView *)tableView {
    HEBEditUserINFOViewController *userINFO = [[HEBEditUserINFOViewController alloc] init];
    userINFO.title = @"更换手机号";
    userINFO.userNormal = getUser_phone;
    [self.viewController.navigationController pushViewController:userINFO animated:YES];
    userINFO.MobNumberChange = ^(NSString *mobNumber) {
        QMUITableViewCell *cell = [tableView cellForRow:2 inSection:0];
        cell.detailTextLabel.text = mobNumber.encryptMobNumber;
    };
}

- (void)editNickName:(QMUITableView *)tableView {
    __weak __typeof(self)weakSelf = self;
    HEBEditUserINFOViewController *userINFO = [[HEBEditUserINFOViewController alloc] init];
    userINFO.title = @"更换昵称";
    userINFO.userNormal = @"nickName".getUserDefaultsINFO;
    [self.viewController.navigationController pushViewController:userINFO animated:YES];
    userINFO.NickNameChange = ^(NSString *nickName) {
        QMUITableViewCell *cell = [tableView cellForRow:2 inSection:0];
        cell.detailTextLabel.text = nickName;
        if (weakSelf.UserNickNameChange) {
            weakSelf.UserNickNameChange(nickName);
        }
    };
}

- (void)editPassWord:(QMUITableView *)tableView {
    HEBEditUserINFOViewController *userINFO = [[HEBEditUserINFOViewController alloc] init];
    userINFO.title = @"更换登录密码";
    userINFO.userNormal = getUser_phone;
    [self.viewController.navigationController pushViewController:userINFO animated:YES];
    userINFO.PasswordChange = ^(NSString *password) {
        QMUITableViewCell *cell = [tableView cellForRow:2 inSection:0];
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < [[getUser_passWord decryptAESString] length]; i ++) {
            [str appendString:@"*"];
        }
        cell.detailTextLabel.text = str;
    };
}

- (void)editPayPassword:(QMUITableView *)tableView {
    HEBEditUserINFOViewController *userINFO = [[HEBEditUserINFOViewController alloc] init];
    userINFO.title = @"更换支付密码";
    userINFO.userNormal = getUser_phone;
    [self.viewControl.navigationController pushViewController:userINFO animated:YES];
}

- (void)forgetPayPassword:(QMUITableView *)tableView {
    HEBEditUserINFOViewController *userINFO = [[HEBEditUserINFOViewController alloc] init];
    userINFO.title = @"忘记支付密码";
    userINFO.userNormal = getUser_phone;
    [self.viewControl.navigationController pushViewController:userINFO animated:YES];
}

- (NSArray<NSArray<NSString *> *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = @[@[@"头像", @"手机号", @"昵称"], @[@"修改登录密码", @"修改支付密码", @"忘记支付密码"]];
    }
    return _cellModelArr;
}

@end
