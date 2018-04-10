//
//  DWGuidePage.m
//DWGuidePageTest
//
//  Created by dwang_sui on 2016/11/8.
//  Copyright © 2016年 dwang. All rights reserved.
//
/******************Github:https://github.com/CoderDwang/DWGuidePage**********************/
/*********邮箱:coderdwang@outlook.com****************/
/*****************************QQ交流群:577506623**************************************/
/*****************************codedata官方群:157937068*****************************/

#define kDWGuidePageVersion @"coderDwangBundleShortVersion"
#define DWScreen_Frame  [UIScreen mainScreen].bounds
#define DWScreen_Width  [UIScreen mainScreen].bounds.size.width
#define DWScreen_Height [UIScreen mainScreen].bounds.size.height
#define DWUser_Defaults [NSUserDefaults standardUserDefaults]

#import "DWGuidePage.h"
#include <math.h>

static BOOL _dwRightAnimation = YES;
static BOOL _dwLeftAnimation = YES;
static BOOL _dwEveryVersionChangeEnabled = YES;
static CGFloat _dwLastDistance = 25.00;

@interface DWGuidePage ()<UIScrollViewDelegate>

@property(nonatomic, strong) NSMutableArray<UIImageView *> *imgsArr;

@property(nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation DWGuidePage

+ (void)configAppWindow:(UIWindow *)window fromGuidePgaeViewController:(UIViewController *)guidePageViewController toMainViewController:(UIViewController *)mainViewController {
    NSString *localShortVersionStr = [[NSUserDefaults standardUserDefaults] objectForKey:kDWGuidePageVersion];
    NSString *currentShortVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if (!localShortVersionStr ||
        ([localShortVersionStr compare:currentShortVersionStr] == NSOrderedAscending && _dwEveryVersionChangeEnabled)) {
        [[NSUserDefaults standardUserDefaults] setObject:currentShortVersionStr forKey:kDWGuidePageVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        window.rootViewController = guidePageViewController;
    }else {
        window.rootViewController = mainViewController;
    }
}

- (instancetype)initWithImgsArray:(NSArray *)imgsArray guidePageCurrentIdx:(DWGuidePageCurrentIdx)guidePageCurrentIdx guidePageCurrentIdxAndCurrentX:(DWGuidePageCurrentIdxAndCurrentX)guidePageCurrentIdxAndCurrentX {
    self = [super initWithFrame:DWScreen_Frame];
    if (self) {
        UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollerView = scrollerView;
        scrollerView.tag = imgsArray.count-1;
        scrollerView.showsHorizontalScrollIndicator = NO;
        scrollerView.pagingEnabled = YES;
        scrollerView.delegate = self;
        scrollerView.backgroundColor = [UIColor whiteColor];
        [scrollerView setContentSize:CGSizeMake(DWScreen_Width*imgsArray.count, 0)];
        __weak __typeof(scrollerView)weakScrollerView = scrollerView;
        __weak __typeof(self)weakSelf = self;
        [imgsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *guidePgaeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(idx*DWScreen_Width, 0, DWScreen_Width, DWScreen_Height)];
            guidePgaeImgView.userInteractionEnabled = YES;
            guidePgaeImgView.tag = idx;
            if ([obj isKindOfClass:[NSString class]]) {
                UIImage *img = [UIImage imageNamed:obj];
                if (img) {
                    guidePgaeImgView.image = img;
                }else {
                    NSAssert(NO, @"未找到添加的内容");
                }
            }else if ([obj isKindOfClass:[UIImage class]]) {
                guidePgaeImgView.image = obj;
            }else {
                NSAssert(NO, @"未识别添加的内容");
            }
            [weakScrollerView addSubview:guidePgaeImgView];
            [weakSelf.imgsArr addObject:guidePgaeImgView];
        }];
        [self addSubview:scrollerView];
        
        self.pageControl.numberOfPages = imgsArray.count;
        [self addSubview:self.pageControl];
        self.guidePageCurrentIdx = ^(NSInteger currentIdx) {
            if (guidePageCurrentIdx) {
                guidePageCurrentIdx(currentIdx);
            }
        };
        if (guidePageCurrentIdx) {//为了初始化完成后走一次回调，手动调起block
            guidePageCurrentIdx(0);
        }
        self.guidePageCurrentIdxAndCurrentX = ^(NSInteger currentIdx, CGFloat currentX, BOOL isSlipEnd) {
            if (guidePageCurrentIdxAndCurrentX) {
                guidePageCurrentIdxAndCurrentX(currentIdx, currentX, isSlipEnd);
            }
        };
    }
    return self;
}

- (TAPageController *)pageControl {
    if (!_pageControl) {
        _pageControl = [[TAPageController alloc] initWithFrame:CGRectMake(0, DWScreen_Height-22, DWScreen_Width, 22)];
    }
    return _pageControl;
}

- (void)setGuidePageBGColor:(UIColor *)guidePageBGColor {
    self.scrollerView.backgroundColor = guidePageBGColor;
}

- (void)setPageHidden:(BOOL)pageHidden {
    self.pageControl.hidden = pageHidden;
}

- (void)setPageCurrentImage:(UIImage *)pageCurrentImage {
    self.pageControl.currentDotImage = pageCurrentImage;
}

- (void)setPageNormalImage:(UIImage *)pageNormalImage {
    self.pageControl.dotImage = pageNormalImage;
}

- (void)setPageY:(CGFloat)pageY {
    self.pageControl.frame = CGRectMake(0, DWScreen_Height-(22+pageY), DWScreen_Width, 22);
}

- (void)setRightAnimation:(BOOL)rightAnimation {
    _dwRightAnimation = rightAnimation;
}

- (void)setLeftEnabled:(BOOL)leftEnabled {
    _dwLeftAnimation = leftEnabled;
}

+ (void)setEveryVersionChangeEnabled:(BOOL)enabled {
    _dwEveryVersionChangeEnabled = enabled;
}

- (void)setLastDistance:(CGFloat)lastDistance {
    _dwLastDistance = lastDistance;
}

- (NSArray<UIImageView *> *)imgs {
    return self.imgsArr;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    double page = x / DWScreen_Width;
    if ((NSInteger)(page + 0.5) > scrollView.tag) {
        return;
    }
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
    if (page == self.pageControl.currentPage && self.guidePageCurrentIdx) {
        self.guidePageCurrentIdx(self.pageControl.currentPage);
        if ([self.delegate respondsToSelector:@selector(guidePageWithCurrentIdx:)]) {
            [self.delegate guidePageWithCurrentIdx:self.pageControl.currentPage];
        }
    }
    if (self.guidePageCurrentIdxAndCurrentX) {
        self.guidePageCurrentIdxAndCurrentX(self.pageControl.currentPage, x, ((x-scrollView.tag*DWScreen_Width)>=_dwLastDistance));
    }
    if ([self.delegate respondsToSelector:@selector(guidePageWithCurrentIdx:andCurrentX:slipPageEnd:)]) {
        [self.delegate guidePageWithCurrentIdx:self.pageControl.currentPage andCurrentX:x slipPageEnd:((x-scrollView.tag*DWScreen_Width)>=_dwLastDistance)];
    }
    
    if (scrollView.contentOffset.x <= 0) {
        if (_dwRightAnimation) {
            self.imgsArr.firstObject.frame = CGRectMake(x, x, DWScreen_Width+ABS(x), DWScreen_Height+ABS(x));
        }else {
            scrollView.scrollEnabled = self.rightEnabled;
        }
    }else {
        scrollView.scrollEnabled = YES;
    }
    if (x >= scrollView.tag*DWScreen_Width) {
        if (_dwLeftAnimation) {
            CGFloat width = DWScreen_Width*scrollView.tag;
            CGFloat left = x - width;
            self.imgsArr.lastObject.frame = CGRectMake(width, -left, DWScreen_Width+left, DWScreen_Height+left);
        }else {
        scrollView.scrollEnabled = self.leftEnabled;
        }
    }else {
        scrollView.scrollEnabled = YES;
    }
}

- (NSMutableArray<UIImageView *> *)imgsArr {
    if (!_imgsArr) {
        _imgsArr = [NSMutableArray array];
    }
    return _imgsArr;
}

@end

