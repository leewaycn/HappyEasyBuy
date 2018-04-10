

#### 开发者账号:
                    qianhoo2017@163.com
                    Mayanan163

###### 商家入驻类型 也是分类ID（1：admins   Foods美食，2：Movie电影，3：Happy休闲娱乐，4：Hotel酒店，5：takeout外卖 ,6：Costume服饰 7:公司企业）

###### 广告图片类型1：金融产品；2：本地生活,3:积分商城广告,4:第一次安装广告,5:打开app的广告,6:美食，7公司

###### 微信支付类型 (1：外卖，6：酒店， 8：美食， 5：电影， 10：服饰， 2：话费， 4:流量， 7:休闲娱乐)

### 目录规范
*     1   建立```AppDelegate```文件夹，存放```AppDelegate```。
*     2   建立```Base```文件夹，存放```基类```。
*     3   建立```Library```文件夹，存放导入的```第三方库```。
*     4   建立```Public```文件夹，存放项目```公共类```。
*     5   建立```Networking```文件夹存放```网络请求基类```。
*     6   建立```Utils```文件夹，存放```工具类```。
*     7   使用```Assets.xcassets```存放```项目图片资源```。
*     8   建立```Resources```存放```其它资源```。
*     9   建立```Entrance```文件夹，按每个模块创建各个模块的子目录，每个模块中都包含Model、View、Controller三个目录，```存放各自的模型、视图、控制器```。



### Entrance文件夹说明
*     1   L&R&F         登录(Login)、注册(Register)、忘记密码(Forget)✅
*     2   LocalLife     本地生活✅
*     3   Vicinity      附近✅
*     4   IntegratedMall    积分商城✅
*     5   Order         订单✅
*     6   MyCenter      个人中心✅
*     7   Feedback      反馈✅
```     8   AboutUs       关于我们 ```
*     9   WKWebView   网页内容(服务协议/关于我们)✅
*     10  Set           设置✅
*     11  Indent        金融产品订单
*     12  Integral      积分
*     13  LifePay       生活缴费
*     14  Location      地址✅
*     15  Merchant      商家入驻✅
*     16  Resume        简历
*     17  ShoppingCar   购物车
*     18  Appraise      我的评价✅
*     19  Balance       余额✅
*     20  Bill          账单
*     21  HappyMoney      乐享币
*     22  Discount      优惠券✅
*     23  Favorite      收藏夹
*     24  Finance       金融理财✅
*     25  PersonalInformation   个人信息✅
```     26  ChangePhoneNum   更改手机号 ```
```    27  ChangeNickName   更换昵称 ```
```    28  ChangePassword   更换密码 ```
*     29  AccountRecharge  账户充值
*     30  OrderList        订单列表✅
``` *     31  ApplyWithdraw    申请提现 ```
*     32  Gastronomy       美食✅
*     33  GastronomyList   美食列表✅
*     34  ShopDetails      店铺详情✅
*     35  Map           地图✅
*     36  GuidePage     引导页
*     37  GetCoupons    领取优惠券✅
*     38  PackageDetails    套餐详情✅
*     39  AllComments   全部评论✅
*     40  FoodSnatchOrderPayment    美食立即抢购订单✅
*     50  OrderPay      订单支付✅
*     51  ChooseCoupons 选择优惠券✅
*     52  Search        美食搜索✅
*     53  BuyOrder      买单
*     54  EditUserINFO  修改用户信息✅
*     55  TakOutDetail  外卖店铺详情✅
*     56  TakOutOrderDetail 外卖订单详情✅
*     57  IntegratedMallGoodsDetail 积分商城商品详情✅
*     58  IntegratedMallOrder   积分商城✅
*     59  PostComments  发表评论✅
*     60  OrderFoodDetail   美食团购/电影/休闲订单详情✅
*     61  OrderHotelDetail  酒店订单详情✅
*     62  OrderTakOutDetail 外卖订单详情✅
*     63  OrderIntegratedDetail 积分订单详情✅
*     64  HotelDetail   酒店详情 逻辑未完成
*     65  ShippingAddress   增加收货地址✅
*     66  AccountBalanceTopUP   余额充值✅
*     67  AccountBalanceWithdrawal  申请提现✅
*     68  AccountBalanceTransfer    转账✅
*     69  HappyMoneyTopUp   乐享币充值✅
*     70  FinanceDetail 金融理财详情✅
*     71  PayPassword   确认支付密码✅
*     72  PaySuccess    支付成功✅(ps:通过外部传入数据进行显示，当前控制器不存在任何数据来源)
*     73  Message   消息中心✅
*     74  MyMerchants   我是商家✅
*     75  HappyMoneyTopupRecord 乐享币充值记录✅
*     76  BalanceRecord 余额使用记录✅

### Utils文件夹说明
*     1  建立```Category```文件夹存放```各类类别扩展```。
*     2  建立```Custom```文件夹存放```自定义类```。
*     3  建立```Configuration```文件夹存放```全局配置文件```。


### UserDefaults存储数据说明
*     1  lon            经度
*     2  lat            纬度
*     3  city_id        城市ID
*     4  userid         用户ID
*     5  header         用户头像
*     6  nickName       用户昵称


----------

