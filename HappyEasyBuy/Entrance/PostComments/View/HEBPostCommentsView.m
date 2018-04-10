//
//  HEBPostCommentsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPostCommentsView.h"
#import <TZImagePickerController.h>

@interface HEBPostCommentsView ()

@property(nonatomic, strong) UIView *starBGView;

@property(nonatomic, strong) UIView *commentsBGView;

@property(nonatomic, strong) NSMutableArray<QMUIButton *> *imgArrM;

@end

@implementation HEBPostCommentsView

- (void)loadView {
    self.backgroundColor = UIColorHex(#f1f1f1);
    
    [self loadStarView];
    
    [self loadCommentsView];
    
    [self loadCommentsIMGView];
    
}

- (void)loadStarView {
    UIView *starBGView = [[UIView alloc] init];
    selfClass(starBGView);
    starBGView.backgroundColor = UIColorWhite;
    [self addSubview:starBGView];
    [starBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_offset(60);
    }];
    
    QMUILabel *allFractions = [[QMUILabel alloc] init];
    allFractions.text = @"总分";
    allFractions.font = UIFontMake(16);
    allFractions.textColor = BASEBLACK;
    [starBGView addSubview:allFractions];
    [allFractions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(starBGView.mas_centerY);
        make.left.equalTo(starBGView.mas_left).offset(15);
        make.width.mas_offset(40);
    }];
    
    RatingBar *star = [[RatingBar alloc] init];
    selfClass(star);
    [star setImageDeselected:@"星评_未选中" halfSelected:nil fullSelected:@"星评_选中" andDelegate:nil];
    [self addSubview:star];
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allFractions.mas_right);
        make.centerY.equalTo(starBGView.mas_centerY);
        make.height.equalTo(starBGView.mas_height).multipliedBy(0.5);
        make.width.mas_offset(150);
    }];
    
}

- (void)loadCommentsView {
    UIView *commentsBGView = [[UIView alloc] init];
    selfClass(commentsBGView);
    commentsBGView.backgroundColor = UIColorWhite;
    [self addSubview:commentsBGView];
    [commentsBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starBGView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    
    QMUILabel *commentsMsg = [[QMUILabel alloc] init];
    commentsMsg.text = @"评价";
    commentsMsg.textColor = BASEBLACK;
    commentsMsg.font = UIFontMake(16);
    [commentsBGView addSubview:commentsMsg];
    [commentsMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentsBGView.mas_left).offset(15);
        make.top.equalTo(commentsBGView.mas_top).offset(10);
    }];
    
    QMUITextView *comment = [[QMUITextView alloc] init];
    selfClass(comment);
    comment.backgroundColor = UIColorHex(#f1f1f1);
    comment.placeholder = @"请输入评价";
    comment.font = UIFontMake(16);
    [commentsBGView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentsMsg.mas_left);
        make.right.equalTo(commentsBGView.mas_right).offset(-15);
        make.top.equalTo(commentsMsg.mas_bottom).offset(10);
        make.bottom.equalTo(commentsBGView.mas_bottom).offset(-10);
    }];
    comment.layer.cornerRadius = 5;
    comment.layer.masksToBounds = YES;
    comment.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
    comment.layer.borderWidth = 1;
    
}

- (void)loadCommentsIMGView {
    UIView *commentsIMGBGView = [[UIView alloc] init];
    commentsIMGBGView.backgroundColor = UIColorWhite;
    [self addSubview:commentsIMGBGView];
    [commentsIMGBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentsBGView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    QMUILabel *uploadIMG = [[QMUILabel alloc] init];
    uploadIMG.text = @"上传图片";
    uploadIMG.textColor = BASEBLACK;
    uploadIMG.font = UIFontMake(16);
    [commentsIMGBGView addSubview:uploadIMG];
    [uploadIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentsIMGBGView.mas_left).offset(15);
        make.top.equalTo(commentsIMGBGView.mas_top).offset(10);
        make.size.mas_offset(CGSizeMake(70, 22));
    }];
    
    for (int i = 0; i < 4; i ++) {
        QMUIButton *img = [[QMUIButton alloc] init];
        img.tag = i;
        img.hidden = i;
        [img setBackgroundImage:UIImageMake(@"订单_上传图片评价") forState:UIControlStateNormal];
        [commentsIMGBGView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uploadIMG.mas_bottom).offset(10);
            make.bottom.equalTo(commentsIMGBGView.mas_bottom).offset(-10);
            make.width.mas_offset(SCREEN_WIDTH/4-10);
            make.left.equalTo(commentsIMGBGView.mas_left).offset(i*(SCREEN_WIDTH/4)+5);
        }];
        [img addTarget:self action:@selector(imgDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imgArrM addObject:img];
    }
}

- (void)imgDidClick:(QMUIButton *)sender {
    TZImagePickerController *tzIMGPick = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    tzIMGPick.sortAscendingByModificationDate = NO;
    tzIMGPick.allowPickingVideo = NO;
    __weak __typeof(self)weakSelf = self;
    @weakify(sender);
    tzIMGPick.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weak_sender setBackgroundImage:photos.lastObject forState:UIControlStateNormal];
        if (weak_sender.tag == weakSelf.imgs.count) {
            [weakSelf.imgs addObject:photos.lastObject];
        }
        [weakSelf.imgs replaceObjectAtIndex:weak_sender.tag withObject:photos.lastObject];
        if (sender.tag < weakSelf.imgArrM.count-1) {
            weakSelf.imgArrM[sender.tag+1].hidden = NO;
        }
    };
    [self.viewController presentViewController:tzIMGPick animated:YES completion:nil];
}

- (NSMutableArray<QMUIButton *> *)imgArrM {
    if (!_imgArrM) {
        _imgArrM = [NSMutableArray array];
    }
    return _imgArrM;
}

- (NSMutableArray<UIImage *> *)imgs {
    if (!_imgs) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}

@end
