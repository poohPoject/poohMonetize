//
//  PoohAdmobNativeMonetize.m
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/11/18.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "PoohAdmobNativeMonetize.h"

@interface PoohAdmobNativeMonetize()<GADNativeAppInstallAdLoaderDelegate, GADNativeContentAdLoaderDelegate>

@property(nonatomic, strong) GADAdLoader *adLoader;


@end

@implementation PoohAdmobNativeMonetize

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)init{
    
    if (self = [super init]) {
        self.nativeAdView = [UIView new];
        self.isAdTypeInstaller = YES;
     //   self.isAdTypeContent = YES;
    }
    return self;
}

- (void)refreshAd:(UIViewController*)viewController {
    // Loads an ad for any of app install, content, or custom native ads.
    NSLog(@"poohAD refreshAd:%@",viewController);
    NSMutableArray *adTypes = [[NSMutableArray alloc] init];
    if (self.isAdTypeInstaller) {
        [adTypes addObject:kGADAdLoaderAdTypeNativeAppInstall];
    }
    
    if (self.isAdTypeContent) {
        [adTypes addObject:kGADAdLoaderAdTypeNativeContent];
    }
    
    if (adTypes.count == 0) {
        NSLog(@"At least one ad format must be selected to refresh the ad.");
    } else {
        self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:@"ca-app-pub-5724013333273072/6035528541"
                                           rootViewController:viewController
                                                      adTypes:adTypes
                                                      options:nil];
        self.adLoader.delegate = self;
        [self.adLoader loadRequest:[GADRequest request]];
    }
}



#pragma mark GADAdLoaderDelegate implementation

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
NSLog(@"poohAD %@ failed with error: %@", adLoader, [error localizedDescription]);

}

#pragma mark GADNativeAppInstallAdLoaderDelegate implementation

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAppInstallAd:(GADNativeAppInstallAd *)nativeAppInstallAd {
  NSLog(@"poohAD Received native app install ad: %@", nativeAppInstallAd);
    
    // Create and place ad in view hierarchy.
    GADNativeAppInstallAdView *appInstallAdView =
    [[[NSBundle mainBundle] loadNibNamed:@"NativeAppInstallAdView" owner:nil options:nil] firstObject];
    [self setAdView:appInstallAdView];

// Associate the app install ad view with the app install ad object. This is required to make the
// ad clickable.
    appInstallAdView.nativeAppInstallAd = nativeAppInstallAd;

    // Populate the app install ad view with the app install ad assets.
    ((UILabel *)appInstallAdView.headlineView).text = nativeAppInstallAd.headline;
    ((UIImageView *)appInstallAdView.iconView).image = nativeAppInstallAd.icon.image;
    ((UILabel *)appInstallAdView.bodyView).text = nativeAppInstallAd.body;
    ((UILabel *)appInstallAdView.storeView).text = nativeAppInstallAd.store;
    ((UILabel *)appInstallAdView.priceView).text = nativeAppInstallAd.price;
    ((UIImageView *)appInstallAdView.imageView).image =
    ((GADNativeAdImage *)[nativeAppInstallAd.images firstObject]).image;
    ((UIImageView *)appInstallAdView.starRatingView).image =
    [self imageForStars:nativeAppInstallAd.starRating];
    [((UIButton *)appInstallAdView.callToActionView)setTitle:nativeAppInstallAd.callToAction
                                                    forState:UIControlStateNormal];
    
    // In order for the SDK to process touch events properly, user interaction should be disabled.
    appInstallAdView.callToActionView.userInteractionEnabled = NO;
}

/// Gets an image representing the number of stars. Returns nil if rating is less than 3.5 stars.
- (UIImage *)imageForStars:(NSDecimalNumber *)numberOfStars {
    double starRating = [numberOfStars doubleValue];
    if (starRating >= 5) {
        return [UIImage imageNamed:@"stars_5"];
    } else if (starRating >= 4.5) {
        return [UIImage imageNamed:@"stars_4_5"];
    } else if (starRating >= 4) {
        return [UIImage imageNamed:@"stars_4"];
    } else if (starRating >= 3.5) {
        return [UIImage imageNamed:@"stars_3_5"];
    } else {
        return nil;
    }
}

#pragma mark GADNativeContentAdLoaderDelegate implementation

- (void)adLoader:(GADAdLoader *)adLoader
didReceiveNativeContentAd:(GADNativeContentAd *)nativeContentAd {
    NSLog(@"poohAD Received native content ad: %@", nativeContentAd);
    
    // Create and place ad in view hierarchy.
    GADNativeContentAdView *contentAdView =
    [[[NSBundle mainBundle] loadNibNamed:@"NativeContentAdView"
                                   owner:nil
                                 options:nil] firstObject];
    [self setAdView:contentAdView];
    
    // Associate the content ad view with the content ad object. This is required to make the ad
    // clickable.
    contentAdView.nativeContentAd = nativeContentAd;
    
    // Populate the content ad view with the content ad assets.
    ((UILabel *)contentAdView.headlineView).text = nativeContentAd.headline;
    ((UILabel *)contentAdView.bodyView).text = nativeContentAd.body;
    ((UIImageView *)contentAdView.imageView).image =
    ((GADNativeAdImage *)[nativeContentAd.images firstObject]).image;
    ((UIImageView *)contentAdView.logoView).image = nativeContentAd.logo.image;
    ((UILabel *)contentAdView.advertiserView).text = nativeContentAd.advertiser;
    [((UIButton *)contentAdView.callToActionView)setTitle:nativeContentAd.callToAction
                                                 forState:UIControlStateNormal];
    
    // In order for the SDK to process touch events properly, user interaction should be disabled.
    contentAdView.callToActionView.userInteractionEnabled = NO;
}


- (void)setAdView:(UIView *)view {
    // Remove previous ad view.
    [self.nativeAdView removeFromSuperview];
    self.nativeAdView = view;
    self.click(self.nativeAdView);
}

@end
