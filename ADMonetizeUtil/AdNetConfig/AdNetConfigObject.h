//
//  AdNetConfigObject.h
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/12/22.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "BaseObject.h"

@interface AdNetConfigObject : BaseObject

@property(nonatomic, assign)BOOL showAdmobInterstitial;//是否展示admob 插屏

//控制是否切换admob的广告id
@property(nonatomic, assign)BOOL changeAdmobBanner;
@property(nonatomic, assign)BOOL changeAdmobInterstitial;

//广告单元
@property(nonatomic, copy)NSString* admobBannerUnit;
@property(nonatomic, copy)NSString* admobInterstitialUnit;

@end
