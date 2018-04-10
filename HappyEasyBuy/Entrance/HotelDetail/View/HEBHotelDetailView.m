//
//  HEBHotelDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelDetailView.h"
#import "HEBRoomDetailsVC.h"
@interface HEBHotelDetailView ()<QMUITableViewDelegate, QMUITableViewDataSource>

/** 入住时间 */
@property(nonatomic, strong) QMUITextField *checkINField;

/** 离店时间 */
@property(nonatomic, strong) QMUITextField *leaveField;

/** 共住几天 */
@property(nonatomic, strong) QMUILabel *days;

@end

@implementation HEBHotelDetailView

- (void)loadView {
    HEBHotelDetailHeaderView *headerView = [[HEBHotelDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220+(IS_58INCH_SCREEN?10:0))];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:self.roomModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0?44:60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?10:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section==0?10:CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = UIColorWhite;
        QMUILabel *checkIn = [[QMUILabel alloc] init];
        checkIn.text = @"入住";
        checkIn.textColor = UIColorGray;
        checkIn.font = UIFontMake(16);
        [header addSubview:checkIn];
        [checkIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(header.mas_left).offset(15);
            make.width.mas_offset(35);
        }];
        QMUITextField *checkINField = [[QMUITextField alloc] init];
        [checkINField endEditing:NO];
        selfClass(checkINField);
        checkINField.placeholder = @"选择入住日期";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *datenow = [NSDate date];
        NSString *currentTimeString = [formatter stringFromDate:datenow];
        checkINField.text = currentTimeString;
        UIDatePicker *checkINDatePicker = [[UIDatePicker alloc] init];
        checkINDatePicker.datePickerMode = UIDatePickerModeDate;
        checkINDatePicker.minimumDate = datenow;
        checkINField.inputView = checkINDatePicker;
        @weakify(checkINDatePicker);
        __weak __typeof(self)weakSelf = self;
        [checkINDatePicker addBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            weakSelf.checkINField.text = [formatter stringFromDate:weak_checkINDatePicker.date];
            weakSelf.days.text = [NSString stringWithFormat:@"共 %ld 天", [weakSelf fromTime:weakSelf.checkINField.text toTime:weakSelf.leaveField.text]];
        }];
        checkINField.font = UIFontMake(16);
        checkINField.textColor = BASEBLACK;
        [header addSubview:checkINField];
        [checkINField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(header);
            make.left.equalTo(checkIn.mas_right).offset(3);
            make.width.mas_offset(108);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorHex(#e7e7e7);
        [header addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.height.equalTo(header.mas_height).offset(-15);
            make.left.equalTo(checkINField.mas_right).offset(10);
            make.width.mas_offset(1);
        }];
        
        QMUILabel *leave = [[QMUILabel alloc] init];
        leave.font = UIFontMake(16);
        leave.text = @"离店";
        leave.textColor = UIColorGray;
        [header addSubview:leave];
        [leave mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(line.mas_right).offset(15);
            make.width.equalTo(checkIn.mas_width);
        }];
        
        QMUITextField *leaveField = [[QMUITextField alloc] init];
        selfClass(leaveField);
        [leaveField endEditing:NO];
        leaveField.font = UIFontMake(16);
        leaveField.textColor = BASEBLACK;
        leaveField.text = [self GetTomorrowDay:datenow];
        leaveField.placeholder = @"选择离店日期";
        UIDatePicker *leaveDatePick = [[UIDatePicker alloc] init];
        leaveDatePick.datePickerMode = UIDatePickerModeDate;
        leaveDatePick.minimumDate = datenow;
        leaveField.inputView = leaveDatePick;
        @weakify(leaveDatePick);
        [leaveDatePick addBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            weakSelf.leaveField.text = [formatter stringFromDate:weak_leaveDatePick.date];
            weakSelf.days.text = [NSString stringWithFormat:@"共 %ld 天", [weakSelf fromTime:weakSelf.checkINField.text toTime:weakSelf.leaveField.text]];
        }];
        [header addSubview:leaveField];
        [leaveField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(header);
            make.left.equalTo(leave.mas_right).offset(3);
            make.width.mas_offset(120);
        }];
        
        QMUILabel *days = [[QMUILabel alloc] init];
        selfClass(days);
        days.font = UIFontMake(16);
        days.textColor = BASECOLOR;
        days.text = @"共 1 晚";
        [header addSubview:days];
        [days mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(leaveField.mas_right);
            make.right.equalTo(header.mas_right).offset(-2);
        }];
        
        return header;
    }
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
    if (indexPath.section == 0) {
        UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"店铺优惠券")];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.size.mas_offset(img.image.size);
        }];
        cell.detailTextLabel.text = self.couponsModelArr.count?[NSString stringWithFormat:@"当前商家共有%ld张优惠券", self.couponsModelArr.count]:@"当前商家暂未推出优惠券";
        cell.userInteractionEnabled = self.couponsModelArr.count;
        cell.accessoryType = self.couponsModelArr.count?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    }else {
        cell.dividingLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        HEBHotelRoomModel *roomModel = self.roomModelArr[indexPath.row];
        QMUILabel *roomName = [[QMUILabel alloc] init];
        roomName.font = UIFontMake(14);
        roomName.text = roomModel.r_name;
        [cell.contentView addSubview:roomName];
        [roomName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.top.equalTo(cell.contentView.mas_top).offset(3);
        }];
        
        QMUILabel *sku = [[QMUILabel alloc] init];
        sku.font = UIFontMake(12);
        sku.textColor = UIColorGray;
        sku.text = roomModel.r_bed;
        [cell.contentView addSubview:sku];
        [sku mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(roomName.mas_left);
            make.centerY.equalTo(cell.contentView.mas_centerY);
        }];
        
        QMUILabel *money = [[QMUILabel alloc] init];
        money.font = UIFontMake(14);
        money.textColor = BASECOLOR;
        money.text = [NSString stringWithFormat:@"¥ %@", roomModel.r_price];
        [cell.contentView addSubview:money];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sku.mas_left);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-3);
        }];
        
        QMUIButton *predetermined = [[QMUIButton alloc] init];
        predetermined.backgroundColor = BASECOLOR;
        predetermined.userInteractionEnabled = NO;
        [predetermined setTitle:@"预定" forState:UIControlStateNormal];
        [predetermined setTitleColor:UIColorWhite forState:UIControlStateNormal];
        predetermined.titleLabel.font = UIFontMake(14);
        [cell.contentView addSubview:predetermined];
        [predetermined mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
            make.height.equalTo(cell.contentView.mas_height).multipliedBy(0.5);
            make.width.equalTo(cell.contentView.mas_height);
        }];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section == 0) {
        
    }else {
        HEBHotelRoomModel *roomModel = self.roomModelArr[indexPath.row];
        NSLog(@"房间id:%@---入住时间:%@----离店时间:%@----%@", roomModel.r_id, self.checkINField.text, self.leaveField.text, self.days.text);
        
        HEBRoomDetailsVC *roomDetailsVC = [[HEBRoomDetailsVC alloc]init];
        roomDetailsVC.rid = self.roomModelArr[indexPath.row].r_id;
        roomDetailsVC.hid = self.hotelid;
//        NSLog(@"%@---%@",self.roomModelArr[indexPath.row].r_id,self.hotelid);
        [self.viewControl.navigationController pushViewController:roomDetailsVC animated:YES];

    }
}

- (NSArray<HEBHotelRoomModel *> *)roomModelArr {
    if (!_roomModelArr) {
        _roomModelArr = [NSArray array];
    }
    return _roomModelArr;
}

- (NSArray<HEBGetCouponsModel *> *)couponsModelArr {
    if (!_couponsModelArr) {
        _couponsModelArr = [NSArray array];
    }
    return _couponsModelArr;
}

- (NSInteger)fromTime:(NSString *)fromTime toTime:(NSString *)toTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormatter dateFromString:fromTime];
    NSDate *date = [dateFormatter dateFromString:toTime];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitDay fromDate:date toDate:date1 options:0];
    return ABS(components.day);
}

- (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}
@end
