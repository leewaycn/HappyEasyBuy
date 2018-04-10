//
//  RequestUrl.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

//接口地址整合

/** 登录 */
#define Login   @"Home/Login/login"

/** 积分商城商品详情 */
#define IntegralGoodsDetails        @"Home/Integral/goodsDetails"

/** 我的积分 */
#define Myintegral   @"home/Integral/showMyintegral"

/** 购物车接口—去结算 */
#define BuyCheck     @"home/Cart/check"

/** 店铺优惠券列表 */
#define CouponList  @"Home/youhui/couponList"

/** 领取优惠券 */
#define GetCoupon   @"Home/youhui/getCoupon"

/** 更新购物车 */
#define UpDateBuyCar    @"home/Cart/updateCart"

/** 外卖商品分类 */
#define TakOutShopCate  @"Home/Shop/shopCate"

/** 购物车列表 */
#define BuyCarList  @"home/Cart/shoppingProducts"

/** 外卖商品列表 */
#define TakOutGoodList  @"Home/Shop/goodsList"

/** 店铺信息 */
#define ShopINFO    @"Home/foods/remark"

/** 外卖商家活动 */
#define TakOutShopActive    @"home/store/ShopList"

/** 修改手机号发送验证码 */
#define EditMobSendMsg    @"Home/Vip/saveMobile"

/** 修改用户名 */
#define EditNickName    @"Home/Vip/upNickname"

/** 修改手机号 */
#define SaveMob @"Home/Vip/endMobile"

/** 改登录密码 */
#define EditPassword    @"home/Password/changePass"

/** 支付订单信息 */
#define PayMsg  @"home/foods/payBill"

/** 商品列表 */
#define Foodslist    @"Home/Foods/foods_list"

/** 美食团购订单提交信息 */
#define FoodOrderDetail @"Home/Foods/orderDetail"

/** 美食团购套餐提交 */
#define FoodPackage   @"Home/Foods/foods_package_reses"

/** 美食团购套餐详情 */
#define FoodPageINFO    @"Home/Foods/foods_package_info"

/** 美食团购商家信息 */
#define FoodINFO    @"Home/Foods/foods_info"

/** 美食团购导航分类 */
#define FoodAllClass    @"Home/Foods/allClass"

/** 美食团购美食分类 */
#define FoodClassify    @"Home/Foods/classify"

/** 优选商品 */
#define FoodFirst    @"Home/Foods/first"

/** 修改用户头像 */
#define EditUserPhoto @"Home/Vip/savePhoto"

/** 反馈 */
#define FeedBack    @"Home/Systemset/feedback"

/** 积分商城列表 */
#define IntegralGoodsList @"Home/Integral/goodsList"

/** 城市id */
#define GetCityID   @"Home/Getcity/backCity"

/** 轮播图 */
#define BannerList  @"Home/Banner/bannerlist"

/** 首页导航分类 */
#define CateClass @"Home/Cate/cateList"

/** 首页热卖商品 */
#define HomeHotGoods    @"Home/Shop/sellingGoods"

/** 密码相关发送验证码 */
#define PasswordSendMsg @"home/Password/sendMessages"

/** 重置密码 */
#define ReSetPassword @"home/Password/resetPassword"

/** 注册发送验证码 */
#define RegisterSendMsg @"Home/Register/sendMessages"

/** 注册 */
#define Register @"Home/Register/register"

/** 图片上传 */
#define UpLoadImg @"home/Shop/img"

/** 订单列表 */
#define OrderList   @"Home/Order/typeOrder"

/** 积分订单 */
#define IntegralOrderList @"home/Integral/"

/** 发表评论 */
#define POSTComments @"Home/Shop/comment"

/** 修改订单状态 */
#define ChangeOrderStatus @"Home/Order/setOrder"

/** 美食订单详情接口 */
#define OrderFoodDetail @"Home/Order/foodsInfo"

/** 休闲娱乐订单详情接口 */
#define OrderFootDetail @"Home/Order/footInfo"

/** 电影订单详情 */
#define OrderMoveDetail @"Home/Order/movieInfo"

/** 酒店订单详情 */
#define OrderHotelDetail @"Home/Order/hotelInfo"

/** 外卖订单详情 */
#define OrderTakOutDetail    @"Home/Order/takeoutInfo"

/** 积分订单详情 */
#define OrderIntegralDetail  @"home/Integral/integralIndentdetails"

/** 酒店详情 */
#define HotelDetail @"Home/Room/hotel_info"

/** 酒店房间列表 */
#define HotelRoomList @"Home/Room/hotel_room_list"

/** 收货地址列表 */
#define UserAddressList @"Home/Vip/addressList"

/** 删除收获地址 */
#define DelUserAddressList  @"Home/Vip/addressDel"

/** 添加收货地址 */
#define UserSetAddress   @"Home/Vip/addressSet"

/** 修改收货地址 */
#define UserChangeAddress    @"Home/Vip/addressSave"

/** 我的评论 */
#define UserCommentList    @"Home/vip/vipComment"

/** 余额 */
#define UserAccountBalance @"Home/Fixed/daily_money"

/** 乐享币 */
#define UserHappyMoney @"Home/Consume/consume_info"

/** 提现信息 */
#define WithdrawalINFO    @"Home/Vip/txList"

/** 申请提现 */
#define WithdrawalRequest  @"Home/Vip/txRequest"

/** 乐享币充值列表 */
#define GetConsume @"home/consume/consume"

/** 我的优惠券 */
#define GetMyCoupon   @"Home/youhui/myCoupon"

/** 获取用户固定收益和昨日收益 */
#define GetEarnings @"Home/Fixed/daily_money"

/** 固定收益产品列表 */
#define GetEarningsList @"Home/Fixed/prolist"

/** 固定收益产品详情 */
#define GetEarningsDetail @"Home/Fixed/proinfo"

/** 商家入驻分类 */
#define GetMerchantCate @"Home/Review/cate"

/** 微信支付买单 */
#define BuyOrderWXPay @"Home/PayBill/wxPay"

/** 微信支付 */
#define WXPay @"Home/Wxpay/testunified"

/** 美食支付宝支付 */
#define GoodsFoodAliPay @"Home/Alipay/foodsAlipay"

/** 验证支付密码是否正确 */
#define CheckPayPass    @"home/Paycode/checkPaycode"

/** 美食余额支付 */
#define GoodsBalancePay  @"Home/Moneypay/foods_package_pay"

/** 美食乐享币支付 */
#define GoodHappyMoneyPay   @"Home/Consume/foods_consumepay"

/** 外卖提交订单 */
#define TakeOutSaveOrder    @"Home/Order/saveOrder"

/** 外卖支付宝支付 */
#define TakeOutAliPay   @"Home/Alipay/wmAlipay"

/** 积分商城兑换商品 */
#define IntegralExchange   @"home/Integral/integralConvertibleGoods"

/** 休闲娱乐套餐列表 */
#define LeisurePackageList @"Home/Happy/foot_package_list"

/** 外卖余额支付 */
#define TakeOutBalancePay @"Home/Vip/moneyPay"

/** 外卖乐享币支付 */
#define TakeOutHappyMoneyPay @"Home/Consume/shop_cousumepay"

/** 买单微信支付 */
#define BayOrerWeChatPay @"Home/PayBill/wxPay"

/** 买单余额支付 */
#define BayOrerBalancePay @"Home/PayBill/balancePay"

/** 买单乐享币买单 */
#define BuyOrderHappyMoneyPay @"/Home/Consume/balance_cousumepay"

/** 验证手机号是否可用 */
#define VerificationPhone @"home/Register/phoneVerify"

/** 发送注册验证码 */
#define SendRegisterMsg @"Home/Register/sendMessages"

/** 用户注册 */
#define Register @"Home/Register/register"

/** 重置密码 */
#define ChnagePassword  @"home/Password/resetPassword"

/** 消息列表 */
#define MessageList @"home/Vip/noticeLsit"

/** 积分商城搜索 */
#define IntegralSearch @"Home/Integral/search"

/** 商家后台 */
#define Server @"Home/Vip/seller"

/** 城市列表 */
#define CityList @"Home/Review/cityList"

/** 商家入驻发送验证码 */
#define SendINMessage @"Home/Review/sendMessages"

/** 商家入驻 */
#define SubmitSHOPINFO @"Home/Review/shopSettle"

/** 修改支付密码 */
#define EditPayPassword @"home/Password/changePay"

/** 重置支付密码 */
#define ReSetPayCode @"home/Password/resetPaycode"

/** 余额微信充值 */
#define BalanceWeChatTopup @"Home/Wxpay/takeBalance"

/** 余额支付宝充值 */
#define BalanceAliTopup @"Home/Alipay/rechargeOrder"

/** 乐享币微信充值 */
#define HappyMoneyWeChatPay @"Home/Wxpay/testunified"

/** 乐享币支付宝充值 */
#define HappyMoneyAliPay @"Home/Alipay/consumeAlipay"

/** 乐享币余额充值 */
#define HappyMoneyBalacePay @"Home/consume/consume_moneypay"

/** 乐享币充值记录列表 */
#define HappyMoneyTopuplist @"Home/Consume/consume_record"

/** 外卖搜索 */
#define TakeoutSearch @"Home/Shop/searchShop"

/** 余额转账记录 */
#define BalanceRecord  @"Home/Record/index"

/** 检测用户是否存在 */
#define ValidationTransferUser @"Home/Transfer/checkAccount"

/** 最多可转金额 */
#define TransferLimit @"Home/transfer/limitMoney"

/** 查询余额 */
#define Balance @"Home/Transfer/balance"

/** 余额转账 */
#define BalanceTransfer @"Home/Transfer/balanceTransfer"

/** 支付宝转账 */
#define TransferAliPay @"Home/Alipay/rechargeOrder"

/** 微信转账 */
#define TransferWeChatPay @"Home/Wxpay/takeBalance"

#endif /* RequestUrl_h */
