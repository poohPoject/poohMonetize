//
//  PoohAdmobInterstitialMonetize.m
//  
//
//  Created by 柯尔祥 on 11/18/16.
//  Copyright © 2016 com.winnie.pooh. All rights reserved.
//


#import "PoohAdmobInterstitialMonetize.h"
#import "UIResponder+TPCategory.h"
#import "AdNetConfigManager.h"



@interface PoohAdmobInterstitialMonetize()<GADInterstitialDelegate>{
    
    NSTimer* timer;//重复检测插屏有效性的定时器

}

@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, strong) GADRequest *request;

@end

@implementation PoohAdmobInterstitialMonetize

/************************************************************************************
 *
 * 单例模式创建对象
 *
 ***********************************************************************************/

+ (PoohAdmobInterstitialMonetize*) shareInstance{
    static PoohAdmobInterstitialMonetize* share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[super allocWithZone:NULL] init];
    });
    return share;
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

/************************************************************************************
 *
 * 广告单元对象的初始化
 *
 ***********************************************************************************/

-(id)init{
    
    if (self = [super init]) {
        [self detectGADInterstitial];
    }
    return self;
}

//监测GAD 的函数
-(void)detectGADInterstitial{
    NSLog(@"detectGADInterstitial");
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
    self.interstitial = [self createAndLoadInterstitial];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkAdIsReady) userInfo:nil repeats:YES];

}

-(void)checkAdIsReady{
    
    if ([self.interstitial isReady]) {
        [timer invalidate];
        timer = nil;
    }
    else{
        [self detectGADInterstitial];
    }
}

//广告加载
- (GADInterstitial *)createAndLoadInterstitial {
    NSLog(@"createAndLoadInterstitial");

    NSString* chapingAD = [[AdNetConfigManager sharedInstance]getConfig].admobInterstitialUnit;
    BOOL ischange = [[AdNetConfigManager sharedInstance]getConfig].changeAdmobInterstitial;
    if (!ischange) {
        chapingAD = POOH_GOOGLE_INTERSTITIAL_UNIT_ID;
    }
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:chapingAD];
    NSLog(@"createAndLoadInterstitial chapingAD:%@",interstitial.adUnitID);
    interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    request.testDevices = @[kGADSimulatorID,@"f6fdcca7862957751c40be842e0cdf9a"];
    
    [interstitial loadRequest:request];
    return interstitial;
}


/************************************************************************************
 *
 * 广告展示
 *
 ***********************************************************************************/


-(void)showGADInterstitial:(UIViewController*)viewController{//显示插屏
    NSLog(@"showGADInterstitial:%@",viewController);
    if (![self.interstitial isReady]) {//广告还没准备好，就去检测
        [self detectGADInterstitial];
    }
    else{
        [self.interstitial presentFromRootViewController:viewController];
    }
}

#pragma GADInterstitial Delegate

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    NSLog(@"interstitialWillDismissScreen");
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");

    [self detectGADInterstitial];

}

@end
