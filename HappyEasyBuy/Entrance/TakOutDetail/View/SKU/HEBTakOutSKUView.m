//
//  HEBTakOutSKUView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutSKUView.h"

@interface HEBTakOutSKUView ()<UIGestureRecognizerDelegate>

/** 当前选中的规格 */
@property(nonatomic, strong) QMUILabel *currentSelectName;

/** 临时存储SKU按钮 */
@property(nonatomic, strong) NSMutableArray<QMUIButton *> *skuArrM;

/** 加入购物车 */
@property(nonatomic, strong) QMUIButton *buyCar;

/** 商品所需金额 */
@property(nonatomic, strong) QMUILabel *money;

/** 当前商品规格 */
@property(nonatomic, strong) QMUILabel *currentSku;

/** 弹框背景 */
@property(nonatomic, strong) UIView *alertBGView;

/** 数量 */
@property(nonatomic, strong) QMUILabel *count;

/** 添加 */
@property(nonatomic, strong) QMUIButton *add;

/** 减少 */
@property(nonatomic, strong) QMUIButton *subtraction;

/** 单价 */
@property(nonatomic, assign) CGFloat price;

/** 记录当前选中的sku */
@property(nonatomic, assign) NSInteger idx;

@end

@implementation HEBTakOutSKUView

- (void)loadAlertView {
    self.backgroundColor = UIColorMakeWithRGBA(1, 1, 1, 0.2);
    UIView *alertBGView = [[UIView alloc] init];
    selfClass(alertBGView);
    alertBGView.backgroundColor = UIColorWhite;
    [self addSubview:alertBGView];
    
    QMUIButton *close = [[QMUIButton alloc] init];
    [close setBackgroundImage:UIImageMake(@"外卖_弹窗关闭") forState:UIControlStateNormal];
    [alertBGView addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertBGView.mas_top).offset(5);
        make.right.equalTo(alertBGView.mas_right).offset(-10);
        make.size.mas_offset(close.currentBackgroundImage.size);
    }];
    __weak __typeof(self)weakSelf = self;
    [close addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf removeAllSubviews];
        [weakSelf removeFromSuperview];
    }];
    
    QMUILabel *currentSelectName = [[QMUILabel alloc] init];
    currentSelectName.text = self.skuModelArr.firstObject.skuattr;
    selfClass(currentSelectName);
    currentSelectName.font = UIFontMake(18);
    [alertBGView addSubview:currentSelectName];
    [currentSelectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(close.mas_centerY);
        make.centerX.equalTo(alertBGView.mas_centerX);
    }];
    
    QMUILabel *skuTitle = [[QMUILabel alloc] init];
    skuTitle.text = @"规格:";
    skuTitle.font = UIFontMake(16);
    [alertBGView addSubview:skuTitle];
    [skuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertBGView.mas_left).offset(10);
        make.top.equalTo(currentSelectName.mas_bottom).offset(15);
    }];
    
    self.idx = 0;
    [self.skuModelArr enumerateObjectsUsingBlock:^(HEBTakOutSKUModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger row = idx/3;
        NSUInteger col = idx%3;
        CGFloat width = SCREEN_WIDTH/5;
        CGFloat height = 24;
        QMUIButton *sku = [[QMUIButton alloc] init];
        [sku setTitle:obj.skuattr forState:UIControlStateNormal>>UIControlStateDisabled];
        sku.enabled = idx==0?NO:YES;
        [sku setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [sku setTitleColor:BASECOLOR forState:UIControlStateDisabled];
        [alertBGView addSubview:sku];
        [sku mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(skuTitle.mas_bottom).offset(row*(height+10)+10);
            make.left.equalTo(skuTitle.mas_right).offset(col*(width+10)+10);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        sku.tag = idx;
        sku.layer.cornerRadius = 5;
        sku.layer.masksToBounds = YES;
        sku.layer.borderColor = (idx==0?BASECOLOR:UIColorHex(#e7e7e7)).CGColor;
        sku.layer.borderWidth = 1;
        [weakSelf.skuArrM addObject:sku];
        [sku addTarget:weakSelf action:@selector(skuDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    QMUIButton *add = [[QMUIButton alloc] init];
    selfClass(add);
    [add setBackgroundImage:UIImageMake(@"外卖_加号") forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addDidClick) forControlEvents:UIControlEventTouchUpInside];
    [alertBGView addSubview:add];
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.alertBGView.mas_right).offset(-10);
        make.top.equalTo(self.skuArrM.lastObject.mas_bottom).offset(10);
        make.size.mas_offset(add.currentBackgroundImage.size);
    }];
    QMUILabel *count = [[QMUILabel alloc] init];
    selfClass(count);
    count.text = [NSString stringWithFormat:@"%d", self.skuModelArr.firstObject.num];
    count.font = UIFontMake(14);
    [alertBGView addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(add.mas_centerY);
        make.right.equalTo(add.mas_left).offset(-5);
    }];
    QMUIButton *subtraction = [[QMUIButton alloc] init];
    selfClass(subtraction);
    [subtraction addTarget:self action:@selector(subtractionDidClick) forControlEvents:UIControlEventTouchUpInside];
    [subtraction setBackgroundImage:UIImageMake(@"外卖_减号") forState:UIControlStateNormal];
    [alertBGView addSubview:subtraction];
    [subtraction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(add.mas_centerY);
        make.right.equalTo(count.mas_left).offset(-5);
        make.size.mas_offset(subtraction.currentBackgroundImage.size);
    }];
    
    QMUIButton *buyCar = [[QMUIButton alloc] init];
    selfClass(buyCar);
    buyCar.backgroundColor = BASECOLOR;
    [buyCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    [buyCar setTitleColor:UIColorWhite forState:UIControlStateNormal];
    buyCar.titleLabel.font = UIFontMake(14);
    [buyCar addTarget:self action:@selector(buyDidClick) forControlEvents:UIControlEventTouchUpInside];
    [alertBGView addSubview:buyCar];
    [buyCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.skuArrM.lastObject.mas_bottom).offset(10);
        make.right.equalTo(alertBGView.mas_right).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    buyCar.layer.cornerRadius = 5;
    buyCar.layer.masksToBounds = YES;
    
    UIView *counterView = [[UIView alloc] init];
    counterView.backgroundColor = UIColorHex(#f1f1f1);
    [alertBGView addSubview:counterView];
    [counterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo((buyCar.hidden?add:buyCar).mas_bottom).offset(15);
        make.left.right.bottom.equalTo(alertBGView);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.text = [NSString stringWithFormat:@"¥ %@", self.skuModelArr.firstObject.price];
    money.textColor = BASECOLOR;
    money.font = UIFontMake(22);
    [counterView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(counterView.mas_centerY);
        make.left.equalTo(counterView.mas_left).offset(15);
    }];
    QMUILabel *currentSku = [[QMUILabel alloc] init];
    selfClass(currentSku);
    currentSku.text = self.skuModelArr.firstObject.skuattr;
    currentSku.textColor = UIColorGray;
    currentSku.font = UIFontMake(14);
    [counterView addSubview:currentSku];
    [currentSku mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(money.mas_bottom);
        make.left.equalTo(money.mas_right);
    }];
    
    QMUIButton *submit = [[QMUIButton alloc] init];
    submit.backgroundColor = BASECOLOR;
    submit.titleLabel.font = UIFontMake(14);
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [counterView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(counterView.mas_centerY);
        make.right.equalTo(counterView.mas_right).offset(-15);
        make.size.mas_offset(CGSizeMake(45, 30));
    }];
    submit.layer.cornerRadius = 5;
    submit.layer.masksToBounds = YES;
    [submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf removeAllSubviews];
        [weakSelf removeFromSuperview];
    }];
    HEBTakOutSKUModel *skuModel = self.skuModelArr.firstObject;
    self.price = skuModel.price.floatValue;
    if (skuModel.num) {
        buyCar.hidden = YES;
        money.text = [NSString stringWithFormat:@"¥ %.2f", skuModel.num*skuModel.price.floatValue];
        count.text = [NSString stringWithFormat:@"%d", skuModel.num];
    }else {
        add.hidden = YES;
        subtraction.hidden = YES;
        count.hidden = YES;
    }
    
    [alertBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(35);
        make.right.equalTo(self.mas_right).offset(-35);
        make.centerY.equalTo(self.mas_centerY);
        make.bottom.equalTo(submit.mas_bottom).offset(15);
    }];
    alertBGView.tag = 100;
    alertBGView.layer.cornerRadius = 5;
    alertBGView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}

- (void)removeSelf {
    [self removeAllSubviews];
    [self removeFromSuperview];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return !(touch.view.tag == 100);
}


- (void)buyDidClick {
    self.count.text = @"1";
    self.buyCar.hidden = YES;
    self.add.hidden = NO;
    self.subtraction.hidden = NO;
    self.count.hidden = NO;
    [self skuModelChange:self.idx];
}

- (void)addDidClick {
    self.count.text = [NSString stringWithFormat:@"%d", self.count.text.intValue+1];
    self.money.text = [NSString stringWithFormat:@"¥ %.2f", self.count.text.floatValue*self.price];
    [self skuModelChange:self.idx];
}

- (void)subtractionDidClick {
    if (self.count.text.intValue <= 1) {
        self.subtraction.hidden = YES;
        self.add.hidden = YES;
        self.buyCar.hidden = NO;
        self.count.hidden = YES;
    }
    self.count.text = [NSString stringWithFormat:@"%d", self.count.text.intValue-1];
    int count = self.count.text.intValue;
    if (!count) {
        count = 1;
    }
    self.money.text = [NSString stringWithFormat:@"¥ %.2f", count*self.price];
    [self skuModelChange:self.idx];
}

- (void)skuDidClick:(QMUIButton *)sku {
    self.idx = sku.tag;
    [self.skuArrM enumerateObjectsUsingBlock:^(QMUIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == sku.tag) {
            obj.enabled = NO;
            obj.layer.borderColor = BASECOLOR.CGColor;
        }else {
            obj.enabled = YES;
            obj.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
        }
    }];
    HEBTakOutSKUModel *model = self.skuModelArr[sku.tag];
    if (model.num) {
        self.add.hidden = NO;
        self.subtraction.hidden = NO;
        self.count.hidden = NO;
        self.buyCar.hidden = YES;
        self.money.text = [NSString stringWithFormat:@"¥ %.2f", model.price.floatValue*model.num];
        self.count.text = [NSString stringWithFormat:@"%d", model.num];
    }else {
        self.add.hidden = YES;
        self.subtraction.hidden = YES;
        self.count.hidden = YES;
        self.buyCar.hidden = NO;
        self.money.text = [NSString stringWithFormat:@"¥ %@", model.price];
    }
    
    self.currentSku.text = model.skuattr;
    self.currentSelectName.text = model.skuattr;
    self.price = model.price.floatValue;
}

- (void)skuModelChange:(NSInteger)tag {
    __weak __typeof(self)weakSelf = self;
    [self.skuModelArr[tag] setNum:weakSelf.count.text.intValue];
    if (self.SKUModelArrChange) {
        self.SKUModelArrChange(self.skuModelArr, tag, self.count.text.intValue, self.skuModelArr[tag].sku);
    }
}

- (NSArray<HEBTakOutSKUModel *> *)skuModelArr {
    if (!_skuModelArr) {
        _skuModelArr = [NSArray array];
    }
    return _skuModelArr;
}

- (NSMutableArray<QMUIButton *> *)skuArrM {
    if (!_skuArrM) {
        _skuArrM = [NSMutableArray array];
    }
    return _skuArrM;
}

@end
