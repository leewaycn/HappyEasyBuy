//
//  HEBHeaderToolsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderListHeaderToolsView.h"

@interface HEBOrderListHeaderToolsView ()

/** 临时存储工具 */
@property(nonatomic, strong) NSMutableArray<QMUIButton *> *toolsArrM;

@end

@implementation HEBOrderListHeaderToolsView

- (void)loadToolsView {
    self.qmui_borderPosition = QMUIBorderViewPositionTop | QMUIBorderViewPositionBottom;
    self.qmui_borderColor = UIColorHex(#e7e7e7);
    self.qmui_borderWidth = 1.f;
    __weak __typeof(self)weakSelf = self;
    [self.toolsArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        [sender setTitle:obj forState:UIControlStateNormal>>UIControlStateDisabled];
        sender.enabled = idx==0?NO:YES;
        sender.tag = idx;
        [sender setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [sender setTitleColor:BASECOLOR forState:UIControlStateDisabled];
        sender.titleLabel.font = UIFontMake(16);
        [weakSelf addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.left.equalTo(weakSelf.mas_left).offset(idx*(SCREEN_WIDTH/weakSelf.toolsArr.count));
            make.width.mas_offset(SCREEN_WIDTH/weakSelf.toolsArr.count);
        }];
        [weakSelf.toolsArrM addObject:sender];
        [sender addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (![sender isEnabled]) {
                return ;
            }
            [weakSelf.toolsArrM enumerateObjectsUsingBlock:^(QMUIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.tag == [sender tag]) {
                    obj.enabled = NO;
                }else {
                    obj.enabled = YES;
                }
            }];
            if (weakSelf.getHeaderToolsDidCick) {
                weakSelf.getHeaderToolsDidCick(weakSelf.toolsArr[idx], [sender tag]);
            }
        }];
    }];
}

- (NSArray<NSString *> *)toolsArr {
    if (!_toolsArr) {
        _toolsArr = [NSArray array];
    }
    return _toolsArr;
}

- (NSMutableArray<QMUIButton *> *)toolsArrM {
    if (!_toolsArrM) {
        _toolsArrM = [NSMutableArray array];
    }
    return _toolsArrM;
}

@end
