//
//  HEBPackagesModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/12.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBPackagesModel : NSObject
    //{
    //                    foot_desc = 嘿嘿嘿;
    //                    foot_name = 大保健;
    //                    foot_num = 1;
    //                    foot_id = 3;
    //                    foot_namedesc = 羞羞的大保健;
    //                    foot_price = 298;
    //                }
    //                ,
    //                {
    //                    foot_desc = 黑恶;
    //                    foot_name = 小保健;
    //                    foot_num = 2;
    //                    foot_id = 4;
    //                    foot_namedesc = 羞羞的小保健;
    //                    foot_price = 360;
    //                }
    
@property(nonatomic, copy)NSString *foot_desc;//描述
@property(nonatomic, copy)NSString *foot_name;//名称
@property(nonatomic, copy)NSString *foot_num;//数量
@property(nonatomic, copy)NSString *foot_id;//id
@property(nonatomic, copy)NSString *foot_namedesc;//名称简述
@property(nonatomic, copy)NSString *foot_price;//价格

    
@end
