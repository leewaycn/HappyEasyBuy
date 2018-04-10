//
//  HEBHotelAllcommentsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelAllcommentsVC.h"
#import "HEBPackageDetailsAppraiseModel.h"
#import "HEBPackageDetailsAppraiseView.h"
#import <KSPhotoBrowser.h>

@interface HEBHotelAllcommentsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(weak, nonatomic)UITableView *allcommentsTableView;
//评论模型数组
@property(nonatomic, strong)NSMutableArray <HEBPackageDetailsAppraiseModel *>*roomCommentArrayM;

@end


static NSString *cellID = @"cellID";
@implementation HEBHotelAllcommentsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部评论";
self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self setupUI];
    [self loadData];
}


-(void)loadData{
    
//http://luntan.guoxiangou.cn/Home/Room/hotelRemark
    NSString *url = @"Home/Room/hotelRemark";
    [Networking postUrl:url params:@{@"shopid":self.rid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        
        self.roomCommentArrayM = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:response[@"data"]]];
        
        NSLog(@"%@", response[@"data"]);

        [self.allcommentsTableView reloadData];
    }];
    
}

-(void)setupUI{
    UITableView *allcommentsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.allcommentsTableView = allcommentsTableView;
    self.allcommentsTableView.delegate = self;
    self.allcommentsTableView.dataSource = self;
    [allcommentsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:allcommentsTableView];
    [allcommentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}


#pragma mark-UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HEBPackageDetailsAppraiseModel *model = self.roomCommentArrayM[indexPath.row];
    return model.content.heightWith14_90+70+(model.icon.count?(SCREEN_WIDTH/6):0)+(model.status?(60+model.reply_cont.heightWith14_90):0);
}


#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.roomCommentArrayM.count;
//    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    __weak typeof(self)weakSelf = self;
    HEBPackageDetailsAppraiseModel *model = self.roomCommentArrayM[indexPath.row];
    HEBPackageDetailsAppraiseView *appraiseView = [[HEBPackageDetailsAppraiseView alloc] init];
    [appraiseView.header yy_setImageWithURL:[NSURL URLWithString:model.headimg] options:YYWebImageOptionProgressive];
    appraiseView.userName.text = model.name;
    appraiseView.time.text = model.time;
    [appraiseView.start displayRating:model.score];
    appraiseView.msg.text = model.content;
    appraiseView.respond.hidden = !model.status;
    appraiseView.bg.hidden = !model.status;
    if (model.status) {
        appraiseView.shopMsg.text = model.reply_cont;
        [appraiseView.shopMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo((model.icon.count?appraiseView.imgArrM.lastObject:appraiseView.msg).mas_bottom).offset(35);
            make.left.equalTo(appraiseView.header.mas_centerX).offset(5);
            make.right.equalTo(appraiseView.mas_right).offset(-15);
        }];
    }
    if (model.icon.count) {
        @weakify(appraiseView);
        NSMutableArray<KSPhotoItem *> *items = [NSMutableArray array];
        [model.icon enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:weak_appraiseView.imgArrM[idx] imageUrl:[NSURL URLWithString:obj]];
            [items addObject:item];
            [weak_appraiseView.imgArrM[idx] yy_setImageWithURL:[NSURL URLWithString:obj] options:YYWebImageOptionProgressive];
            [weak_appraiseView.imgArrM[idx] setUserInteractionEnabled:YES];
            [weak_appraiseView.imgArrM[idx] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:idx];
                [browser showFromViewController:weakSelf];
            }]];
        }];
    }else {
        [appraiseView.imgArrM enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [appraiseView.imgArrM removeAllObjects];
    }
    [cell.contentView addSubview:appraiseView];
    [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dividingLine = YES;

    return cell;
}



@end
