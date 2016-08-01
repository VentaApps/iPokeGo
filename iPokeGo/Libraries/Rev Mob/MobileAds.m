//
//  MobileAds.m
//  Focus
//
//  Created by VentaApps on 5/25/16.
//  Copyright © 2016 VentaApps. All rights reserved.
//

#import "MobileAds.h"
#import "AppDelegate.h"

@interface MobileAds ()
//@property (nonatomic, strong)RevMobAdLink *nativeLink;
@property (nonatomic, strong) RevMobFullscreen *rmfs;
@property (nonatomic, strong) RevMobBannerView *rmbv;
@property (nonatomic) BOOL adsSessionStarted;

@end


@implementation MobileAds
//@synthesize nativeLink;
@synthesize adsSessionStarted;
@synthesize rmfs;
@synthesize rmbv;


#pragma mark - Singleton Method
//- (id)init {
//    if (self = [super init]) {
//        
//    }
//    return self;
//}
+ (id)sharedAdsManager {
    static MobileAds *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


#pragma mark - Main Methods
-(void)startFullScreenAds {
    if (!adsSessionStarted) {
        [RevMobAds startSessionWithAppID:@"579a0829b28952630b184aca"
                      withSuccessHandler:^{
                          adsSessionStarted = YES;
                          rmfs = [[RevMobAds session] fullscreen];
                          rmbv = [[RevMobAds session] bannerView];
                          rmbv.delegate = self;
                          [self showFullscreenAd];
                      } andFailHandler:^(NSError *error) {
                          
                      }];
        [RevMobAds session].userAgeRangeMin = 10;
    }
    else {
        [self showFullscreenAd];
    }
}

-(void)startBannerAds {
    if (!adsSessionStarted) {
        [RevMobAds startSessionWithAppID:@"579a0829b28952630b184aca"
                      withSuccessHandler:^{
                          adsSessionStarted = YES;
                          rmfs = [[RevMobAds session] fullscreen];
                          rmbv = [[RevMobAds session] bannerView];
                          rmbv.delegate = self;
                          [self showBanner];
                      } andFailHandler:^(NSError *error) {
                          
                      }];
        [RevMobAds session].userAgeRangeMin = 10;
    }
    else {
        [self showBanner];
    }
    
    
}

-(void)hideBanner {
    if([rmbv isDescendantOfView:[[UIApplication sharedApplication] keyWindow]])
        [rmbv removeFromSuperview];
}


#pragma mark - Helper Methods
-(void)showFullscreenAd {
    
    [rmfs loadWithSuccessHandler:^(RevMobFullscreen *fs) {
        [fs showAd];
    } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
        //Do something when it fails to load
    } onClickHandler:^{
        //Do something when the user clicks on it
    } onCloseHandler:^{
        //Do something when the user closes it
        [rmfs hideAd];
    }];
}

-(void)showBanner {
    
    [rmbv loadWithSuccessHandler:^(RevMobBannerView *bannerView) {
        [bannerView showAd];
        if(![rmbv isDescendantOfView:[[UIApplication sharedApplication] keyWindow]])
            [[[UIApplication sharedApplication] keyWindow] addSubview:bannerView];
//        [[[UIApplication sharedApplication] keyWindow] sendSubviewToBack:bannerView];
    } andLoadFailHandler:^(RevMobBannerView *bannerView, NSError *error) {
        [bannerView removeFromSuperview];
        [self revmobAdDidFailWithError:error];
    } onClickHandler:^(RevMobBannerView *bannerView) {
        [self revmobUserClickedInTheAd];
    }];
    
}

-(void)revmobAdDidReceive {
    NSLog(@"[RevMob Sample App] Ad loaded.");
}

-(void)revmobAdDidFailWithError:(NSError *)error {
    NSLog(@"[RevMob Sample App] Ad failed: %@", error);
}

-(void)revmobAdDisplayed {
    NSLog(@"[RevMob Sample App] Ad displayed.");
}

-(void)revmobUserClosedTheAd {
    NSLog(@"[RevMob Sample App] User clicked in the close button.");
}

-(void)revmobUserClickedInTheAd {
    NSLog(@"[RevMob Sample App] User clicked in the Ad.");
}


@end
