//
//  PoohAdmobNativeMonetize.h
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/11/18.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

typedef void(^ClickBlock)(id object);
typedef void(^ClickBlockEx)(id object, id param);
typedef void(^ClickBlockThree)(id object, id param1,id param2);
typedef void(^ClickBlockFour)(id object, id param1,id param2, id param3);


@interface PoohAdmobNativeMonetize : UIView

@property(nonatomic, strong) UIView *nativeAdView;

@property(nonatomic, assign) BOOL isAdTypeInstaller;//yes: 应用安装广告
@property(nonatomic, assign) BOOL isAdTypeContent;//yes:内容广告
- (void)refreshAd:(UIViewController*)viewController;

@property(nonatomic,strong)ClickBlock click;

@end
