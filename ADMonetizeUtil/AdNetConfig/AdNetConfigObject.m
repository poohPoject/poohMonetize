//
//  AdNetConfigObject.m
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/12/22.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "AdNetConfigObject.h"
#import "PoohMonetizePublic.h"
@implementation AdNetConfigObject

- (id)init{
    if (self = [super init]) {
        
        
        self.showAdmobInterstitial = YES;//是否展示admob 插屏
        
        //控制是否切换admob的广告id
        self.changeAdmobBanner = NO;
        self.changeAdmobInterstitial = NO;
        
        //广告单元
        self.admobBannerUnit = POOH_GOOGLE_BANNERVIEW_UNIT_ID;
        self.admobInterstitialUnit = POOH_GOOGLE_INTERSTITIAL_UNIT_ID;
        
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"showAdmobInterstitial"    :@"showAdmobInterstitial",
             @"changeAdmobBanner"        :@"changeAdmobBanner",
             @"changeAdmobInterstitial"  :@"changeAdmobInterstitial",
             @"admobBannerUnit"          :@"admobBannerUnit",
             @"admobInterstitialUnit"    :@"admobInterstitialUnit",
             };
}
@end
