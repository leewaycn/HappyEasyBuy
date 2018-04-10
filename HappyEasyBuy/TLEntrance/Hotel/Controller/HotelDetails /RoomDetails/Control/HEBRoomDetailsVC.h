//
//  HEBRoomDetailsVC.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEBHotelRoomModel.h"
@interface HEBRoomDetailsVC : UIViewController
//酒店ID
@property(nonatomic, copy)NSString *hid;
//房间ID
@property(nonatomic, copy)NSString *rid;

//@property(strong,nonatomic)NSMutableArray <HEBHotelRoomModel*> *hotelRoomModelArrM;

@end

