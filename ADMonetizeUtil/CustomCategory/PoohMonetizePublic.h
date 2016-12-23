//
//  PoohMonetizePublic.h
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/11/18.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#ifndef PoohMonetizePublic_h
#define PoohMonetizePublic_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#import "PoohAdmobBannerMonetize.h"
#import "PoohAdmobInterstitialMonetize.h"
#import "PoohAdmobNativeMonetize.h"
#import "GameCenterManager.h"

///获取delegate
#define APP_DELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

///当前屏幕rect
#define DeviceRect [UIScreen mainScreen].bounds
///当前屏幕宽度
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
///当前屏幕高度
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
//当前导航栏高度
#define NavHeight self.navigationController.navigationBar.frame.size.height
//当前Tab高度
#define TabHeight self.tabBarController.tabBar.frame.size.height

#endif /* PoohMonetizePublic_h */
