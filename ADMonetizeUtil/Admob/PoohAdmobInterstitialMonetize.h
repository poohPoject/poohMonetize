//
//  PoohAdmobInterstitialMonetize.h
//
//
//  Created by 柯尔祥 on 11/18/16.
//  Copyright © 2016 com.winnie.pooh. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GoogleMobileAds;



//banner id

#define POOH_GOOGLE_INTERSTITIAL_UNIT_ID @"ca-app-pub-3940256099942544/4411468910"



@interface PoohAdmobInterstitialMonetize : UIView
+(PoohAdmobInterstitialMonetize*) shareInstance;//创建单例对象

-(void)showGADInterstitial:(UIViewController*)viewController;//显示插屏

@end
