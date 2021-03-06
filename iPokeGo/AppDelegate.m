//
//  AppDelegate.m
//  iPokeGo
//
//  Created by Dimitri Dessus on 21/07/2016.
//  Copyright © 2016 Dimitri Dessus. All rights reserved.
//

#import "AppDelegate.h"
#import "NSUserDefaults+GroundControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.15 green:0.20 blue:0.23 alpha:1.0]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self initializeGroundControl];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

///////////////////////////////////////////
#pragma mark - GroundControl
//////////////////////////////////////////
- (void)initializeGroundControl {
    
    NSURL *url = [NSURL URLWithString:@"http://plists.ventaapps.com/PokeMonGoConfig.txt"];
//    NSURL *url = [NSURL URLWithString:@"http://web.textfiles.com/destruction/000.txt"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [[NSUserDefaults standardUserDefaults] registerDefaultsWithURLRequest:request
     success:^(NSURLRequest *urlRequest, NSHTTPURLResponse *urlResponse, NSDictionary *dict)
     {
         if ([dict objectForKey:@"ServerAddress"]) {
             [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"ServerAddress"] forKey:@"server_addr"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"ServerAddressLoaded"
                                                                 object:nil userInfo:nil];
         }
     }
     failure:^(NSURLRequest *urlRequest, NSHTTPURLResponse *urlResponse, NSError *error)
     {
         //        NSLog(@"Error > %@ with user info %@.", error, [error userInfo]);
     }];
//    [[NSUserDefaults standardUserDefaults] registerDefaultsWithURL:url
//                                                           success:^(NSDictionary *dict) {
//                                                               // ...
//                                                           } failure:^(NSError *error) {
//                                                               // ...
//                                                           }];
}


@end
