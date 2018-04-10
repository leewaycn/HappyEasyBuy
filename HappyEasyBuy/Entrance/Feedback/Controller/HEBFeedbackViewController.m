//
//  HEBFeedbackViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFeedbackViewController.h"
#import "HEBFeedBackView.h"

@interface HEBFeedbackViewController ()

@property(nonatomic, strong) HEBFeedBackView *feedBackView;

@property(nonatomic, strong) QMUITextView *msgText;

@end

@implementation HEBFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.scrollEnabled = YES;
}

- (void)setUI {
    if ([self.title isEqualToString:@"求助反馈"]) {
        HEBFeedBackView *feedBackView = [[HEBFeedBackView alloc] init];
        selfClass(feedBackView);
        [self.baseView addSubview:feedBackView];
        [feedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.bottom.equalTo(self.view);
        }];
        [feedBackView.submit addTarget:self action:@selector(submitDidClick) forControlEvents:UIControlEventTouchUpInside];
    }else {
        self.baseView.dividingLine = YES;
        self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"完成" tintColor:UIColorBlack position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
        QMUITextView *msgText = [[QMUITextView alloc] init];
        selfClass(msgText);
        msgText.placeholder = @"口味偏好等";
        msgText.backgroundColor = UIColorHex(#f1f1f1);
        msgText.font = UIFontMake(16);
        [self.baseView addSubview:msgText];
        [msgText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top).offset(15);
            make.left.equalTo(self.view.mas_left).offset(25);
            make.right.equalTo(self.view.mas_right).offset(-25);
            make.height.equalTo(self.view.mas_width).multipliedBy(0.4);
        }];
        msgText.layer.cornerRadius = 5;
        msgText.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
        msgText.layer.borderWidth = 1;
        msgText.layer.masksToBounds = YES;
    }
}

- (void)submitDidClick {
    if (self.feedBackView.feedBackText.text.length < 10) {
        [ISMessages showCardAlertWithTitle:@"提交失败" message:@"输入内容过少,请进行详细描述" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FeedBack params:@{@"content":self.feedBackView.feedBackText.text, @"mobile":self.feedBackView.mobNumber.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            [ISMessages showCardAlertWithTitle:@"反馈成功" message:@"您已成功反馈，请耐心等待" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)rightBarButtonItemDidClick {
    if (self.getConnect) {
        self.getConnect(self.msgText.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
