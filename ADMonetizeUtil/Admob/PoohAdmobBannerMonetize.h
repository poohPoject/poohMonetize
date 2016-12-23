//
//  PoohAdmobBannerMonetize.h
//  netNovel
//
//  Created by 柯尔祥 on 11/18/16.
//  Copyright © 2016年 com.winnie.pooh. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define GOOGLE_BANNERVIEW_UNIT_ID @"ca-app-pub-5724013333273072/2720541745"


@import GoogleMobileAds;

#define POOH_GOOGLE_BANNERVIEW_SIZE_IPHONE 50
#define POOH_GOOGLE_BANNERVIEW_SIZE_IPAD 90
#define POOH_GOOGLE_BANNERVIEW_UNIT_ID @"ca-app-pub-3940256099942544/2934735716"

@interface PoohAdmobBannerMonetize : UIView

-(void)showGADBannerView:(UIViewController*)viewController;//显示banner
-(GADBannerView*)getBannerObject;


@end
