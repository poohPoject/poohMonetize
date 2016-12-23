#ifndef __LongChengDaRen__IOSiAP_Bridge__
#define __LongChengDaRen__IOSiAP_Bridge__

#import "IOSiAP.h"

enum{
    IAPGold300=10,
    IAPGold600,
    IAPGold1200,
    IAPGold2400,
    IAPGift0,
    IAPGift1,
    IAPGift2,
    
}productTag;

class IOSiAP_Bridge : public IOSiAPDelegate
{
public:
    IOSiAP_Bridge();
    ~IOSiAP_Bridge();
    static IOSiAP_Bridge* sharedIOSiAP_Bridge();
    IOSiAP *iap;
    int productID;
    void requestProducts(int);
    virtual void onRequestProductsFinish(void);
    virtual void onRequestProductsError(int code);
    virtual void onPaymentEvent(std::string &identifier, IOSiAPPaymentEvent event, int quantity);
};
#endif /* defined(__LongChengDaRen__IOSiAP_Bridge__) */
