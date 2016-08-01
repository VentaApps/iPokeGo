//
//  MobileAds.h
//  Focus
//
//  Created by VentaApps on 5/25/16.
//  Copyright © 2016 VentaApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RevMobAds/RevMobAds.h>

@interface MobileAds : NSObject<RevMobAdsDelegate>

+ (id)sharedAdsManager;

-(void)startFullScreenAds;
-(void)startBannerAds;
-(void)hideBanner;

@end
