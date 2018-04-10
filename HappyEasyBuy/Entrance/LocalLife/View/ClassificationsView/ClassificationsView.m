//
//  ClassificationsView.m
//  test
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "ClassificationsView.h"

@interface ClassificationsView ()<UIScrollViewDelegate>

/** 主体视图 */
@property(nonatomic, strong) UIScrollView *scroller;

/** 暂存数据源 */
@property(nonatomic, strong) NSArray<HEBClassificationModel *> *dataArr;

/** 暂存最大行数 */
@property(nonatomic, assign) int maxRowCount;

/** 暂存最大个数/行 */
@property(nonatomic, assign) int maxRow;

/** 暂存页码控制器 */
@property(nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ClassificationsView

- (void)setClassificationsViewDataArr:(NSArray *)dataArr maxRowCount:(int)maxRowCount maxRow:(int)maxRow didClickClassifications:(didClickClassifications)didClickClassifications {
    self.dataArr = dataArr;
    self.maxRowCount = maxRowCount;
    self.maxRow = maxRow;
    int count = (int)ceilf([NSString stringWithFormat:@"%ld", dataArr.count].floatValue/(maxRow*maxRowCount));
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.numberOfPages = count;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = UIColorGray;
    [self addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
    }];
    UIScrollView *scroller = [[UIScrollView alloc] init];
    scroller.showsVerticalScrollIndicator = NO;
    scroller.showsHorizontalScrollIndicator = NO;
    self.scroller = scroller;
    scroller.delegate = self;
    scroller.pagingEnabled = YES;
    [self addSubview:scroller];
    [scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(pageControl.mas_top);
    }];
    [scroller setContentSize:CGSizeMake(count*SCREEN_WIDTH, 0)];
    [self setClassView];
    self.didClickClassifications = ^(HEBClassificationModel *model) {
        if (didClickClassifications) {
            didClickClassifications(model);
        }
    };
}

- (void)setClassView {
    __weak __typeof(self)weakSelf = self;
    [self.dataArr enumerateObjectsUsingBlock:^(HEBClassificationModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = SCREEN_WIDTH/weakSelf.maxRowCount;
        CGFloat height = 80;
        QMUIButton *sender = [[QMUIButton alloc] init];
        sender.backgroundColor = UIColorClear;
        sender.tag = idx;
        [sender addTarget:weakSelf action:@selector(classificationsDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.scroller addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(width, height));
            make.top.equalTo(weakSelf.mas_top).offset((idx/weakSelf.maxRowCount%weakSelf.maxRow)*height);
            make.left.equalTo(weakSelf.scroller.mas_left).offset(((idx%weakSelf.maxRowCount)*width)+(idx/weakSelf.maxRowCount/weakSelf.maxRow)*weakSelf.width);
        }];
        UIImageView *img = [[UIImageView alloc] init];
        [img yy_setImageWithURL:[NSURL URLWithString:obj.icon] options:YYWebImageOptionProgressive];
        [sender addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(sender);
            make.size.mas_offset(width/2);
        }];
        [img layoutIfNeeded];
        img.layer.cornerRadius = img.width/2;
        img.layer.masksToBounds = YES;
        
        QMUILabel *lab = [[QMUILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = obj.name;
        lab.font = UIFontMake(11);
        lab.textColor = UIColorMake(104, 104, 104);
        [sender addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(sender.mas_bottom);
            make.left.right.equalTo(sender);
        }];
    }];
}

- (void)classificationsDidClick:(QMUIButton *)sender {
    if (self.didClickClassifications) {
        self.didClickClassifications(self.dataArr[sender.tag]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

@end
