//
//  PoohAdmobBannerMonetize.m
//
//
//  Created by 柯尔祥 on 11/18/16.
//  Copyright © 2016年 com.winnie.pooh. All rights reserved.
//

#import "PoohAdmobBannerMonetize.h"
#import "UIResponder+TPCategory.h"
#import "AdNetConfigManager.h"


@interface PoohAdmobBannerMonetize()<GADBannerViewDelegate>

@property(nonatomic, strong) GADRequest *request;
@property(nonatomic, retain) GADBannerView *banner;

@end

@implementation PoohAdmobBannerMonetize

-(GADBannerView*)getBannerObject{
    
    if (self.banner) {
        return self.banner;
    }
    
    self.banner = [[GADBannerView alloc]init];
    
    // BOOL isChange = [[SystemNetConfigUtil sharedInstance]getConfig].changeAD;
    
    NSString* bannerStr = [[AdNetConfigManager sharedInstance]getConfig].admobBannerUnit;
    BOOL ischange = [[AdNetConfigManager sharedInstance]getConfig].changeAdmobBanner;
    if (!ischange) {
        bannerStr = POOH_GOOGLE_BANNERVIEW_UNIT_ID;
    }
    self.banner.adUnitID = bannerStr;
    NSLog(@"getBannerObject adUnitAD:%@",self.banner.adUnitID);
    self.request=[GADRequest request];
    self.request.testDevices=@[@"f6fdcca7862957751c40be842e0cdf9a",kGADSimulatorID];

    
    return self.banner;
}

-(void)showGADBannerView:(UIViewController*)viewController{//显示banner
    NSLog(@"showGADBannerView:%@",viewController);

    self.banner.rootViewController = viewController;
    [self.banner loadRequest:self.request];
}

#pragma GADBannerView Delegate

#pragma mark Ad Request Lifecycle Notifications

/// Tells the delegate that an ad request successfully received an ad. The delegate may want to add
/// the banner view to the view hierarchy if it hasn't been added yet.
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    NSLog(@"adViewDidReceiveAd");

}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"didFailToReceiveAdWithError");

}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{

}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView{

}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView{

}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{

}



@end
