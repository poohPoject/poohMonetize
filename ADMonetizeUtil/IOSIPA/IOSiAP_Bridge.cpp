#include "IOSiAP_Bridge.h"
//#include "cocos2d.h"
//#include "DataPool.h"

USING_NS_CC;

IOSiAP_Bridge::IOSiAP_Bridge()
{
    iap = new IOSiAP();
    iap->delegate = this;
}

IOSiAP_Bridge::~IOSiAP_Bridge()
{
    delete iap;
}
/*
#define ProductID_IAPGold300 @"com.131701.protectmermaid.product0"//$0.99
#define ProductID_IAPGold600 @"com.131701.protectmermaid.product2"//$0.99
#define ProductID_IAPGold1200 @"com.131701.protectmermaid.product3"//$0.99
#define ProductID_IAPGold2400 @"com.131701.protectmermaid.product4"//$0.99
#define ProductID_IAPGift0 @"com.131701.protectmermaid.product5"//$0.99
#define ProductID_IAPGift1 @"com.131701.protectmermaid.product6"//$0.99
#define ProductID_IAPGift2 @"com.131701.protectmermaid.product7"//$0.99
*/

static IOSiAP_Bridge * _sharedHelper;

IOSiAP_Bridge* IOSiAP_Bridge::sharedIOSiAP_Bridge(){
    
    if (_sharedHelper != NULL) {
        return _sharedHelper;
    }
    _sharedHelper = new IOSiAP_Bridge();
    return _sharedHelper;
    
}



void IOSiAP_Bridge:: requestProducts(int id)
{
    productID = id;
    std::vector<std::string> product;
    product.push_back("com.131701.zlprotectmermaid.product0");
    product.push_back("com.131701.zlprotectmermaid.product1");
    product.push_back("com.131701.zlprotectmermaid.product2");
    product.push_back("com.131701.zlprotectmermaid.product3");
    product.push_back("com.131701.zlprotectmermaid.product4");
    product.push_back("com.131701.zlprotectmermaid.product5");
    product.push_back("com.131701.zlprotectmermaid.product6");
	//把需要付费的道具的所有product id都放到容器里面传进去
    iap->requestProducts(product);
}

void IOSiAP_Bridge::onRequestProductsFinish(void)
{
    std::string identifier = "";
    switch (productID) {
        case IAPGold300:
            identifier = "com.131701.zlprotectmermaid.product0";
            break;
        case IAPGold600:
            identifier = "com.131701.zlprotectmermaid.product1";
            break;
        case IAPGold1200:
            identifier = "com.131701.zlprotectmermaid.product2";
            break;
        case IAPGold2400:
            identifier = "com.131701.zlprotectmermaid.product3";
            break;
        case IAPGift0:
            identifier = "com.131701.zlprotectmermaid.product4";
            break;
        case IAPGift1:
            identifier = "com.131701.zlprotectmermaid.product5";
            break;
        case IAPGift2:
            identifier = "com.131701.zlprotectmermaid.product6";
            break;
        default:
            break;
    }

    //必须在onRequestProductsFinish后才能去请求iAP产品数据。
    IOSProduct *product = iap->iOSProductByIdentifier(identifier);
    // 然后可以发起付款请求。,第一个参数是由iOSProductByIdentifier获取的IOSProduct实例，第二个参数是购买数量
    iap->paymentWithProduct(product, 1);
}

void IOSiAP_Bridge::onRequestProductsError(int code)
{
    //这里requestProducts出错了，不能进行后面的所有操作。
    CCLOG("付款失败");
}

void IOSiAP_Bridge::onPaymentEvent(std::string &identifier, IOSiAPPaymentEvent event, int quantity)
{
    
    if (event == IOSIAP_PAYMENT_PURCHAED) {
        //付款成功了，可以吧金币发给玩家了。
		//根据传入的参数就能知道购买的是哪种类型的金币
        
        u32 gold = getUserStoreData().getGold();
        switch (productID) {
            case IAPGold300:
                CCLOG("gold 300");
                gold+=360;
                break;
            case IAPGold600:
                CCLOG("gold 600");
                gold+=750;
                break;
            case IAPGold1200:
                CCLOG("gold 1200");
                gold+=1560;
                break;
            case IAPGold2400:
                CCLOG("gold 2400");
                gold+=3600;
               
                break;
                
            case IAPGift0:
                CCLOG("gift0");
                gold+=300;
                getUserStoreData().setPropNum(1, getUserStoreData().getPropNum(1)+10);
                break;
            case IAPGift1:
                CCLOG("gift1");
                gold+=1000;
                getUserStoreData().setPropNum(1, getUserStoreData().getPropNum(1)+3);
                getUserStoreData().setPropNum(2, getUserStoreData().getPropNum(2)+3);
                getUserStoreData().setPropNum(3, getUserStoreData().getPropNum(3)+3);
                getUserStoreData().setPropNum(4, getUserStoreData().getPropNum(4)+3);
                break;
            case IAPGift2:
                CCLOG("gift2");
                gold+=5200;
                getUserStoreData().setPropNum(1, getUserStoreData().getPropNum(1)+12);
                getUserStoreData().setPropNum(2, getUserStoreData().getPropNum(2)+12);
                getUserStoreData().setPropNum(3, getUserStoreData().getPropNum(3)+12);
                getUserStoreData().setPropNum(4, getUserStoreData().getPropNum(4)+12);
                
                break;
            default:
                break;
        }
        getUserStoreData().setGold(gold);
        getUserStoreData().saveUserData();
        CCLOG("付款成功");
        
    }
    //其他状态依情况处理掉。
}
