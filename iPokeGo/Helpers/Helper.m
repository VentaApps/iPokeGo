//
//  Helper.m
//  Focus
//
//  Created by VentaApps on 5/23/16.
//  Copyright © 2016 VentaApps. All rights reserved.
//

#import "Helper.h"
#import "MobileAds.h"

@implementation Helper

+(void)startAds {
    [[MobileAds sharedAdsManager] startBannerAds];
    [[MobileAds sharedAdsManager] startFullScreenAds];
}

+(void)startBannerAds {
    [[MobileAds sharedAdsManager] startBannerAds];
}

+(void)startFullScreenAds {
    [[MobileAds sharedAdsManager] startFullScreenAds];
}

+(void)hideBanner {
    [[MobileAds sharedAdsManager] hideBanner];
}

@end
