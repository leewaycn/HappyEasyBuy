//
//  HEBPostCommentsViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPostCommentsViewController.h"
#import "HEBPostCommentsView.h"

@interface HEBPostCommentsViewController ()

@property(nonatomic, strong) HEBPostCommentsView *commentsView;

@end

@implementation HEBPostCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.baseView.scrollEnabled = YES;
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"发表" tintColor:UIColorBlack position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    HEBPostCommentsView *commentsView = [[HEBPostCommentsView alloc] init];
    selfClass(commentsView);
    [self.baseView addSubview:commentsView];
    [commentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)rightBarButtonItemDidClick {
    [self.progressHUD showAnimated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%f", self.commentsView.star.rating] forKey:@"score"];
    [params setObject:getUser_id forKey:@"vipid"];
    [params setObject:self.shop_id forKey:@"shopid"];
    [params setObject:self.orderNumber forKey:@"order_id"];
    [params setObject:self.commentsView.comment.text forKey:@"content"];
    [params setObject:self.type forKey:@"type"];
    __weak __typeof(self)weakSelf = self;
    NSMutableString *imgUrls = [NSMutableString string];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf.commentsView.imgs enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj uploadIMGWithCallBack:^(id response, NSString *urlString, NSError *errorData) {
                [imgUrls appendString:[NSString stringWithFormat:@"\"%@\",", urlString]];
                if (idx == weakSelf.commentsView.imgs.count-1) {
                    [params setObject:[NSString stringWithFormat:@"{%@}", imgUrls] forKey:@"data"];
                    [Networking postUrl:POSTComments params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                        [weakSelf dismissProgressHUD];
                        if (mainModel.status) {
                            [ISMessages showCardAlertWithTitle:@"评价成功" message:@"您已成功发表评价" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:0 didHide:nil];
                            if (weakSelf.CommentSuccess) {
                                weakSelf.CommentSuccess();
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }
                        }else {
                            [ISMessages showCardAlertWithTitle:@"评价失败" message:@"您发表的评价好像失败了" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:0 didHide:nil];
                        }
                    }];
                }
            }];
        }];
    });
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
