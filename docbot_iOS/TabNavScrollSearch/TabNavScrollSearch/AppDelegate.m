//
//  AppDelegate.m
//  TabNavScrollSearch
//
//  Created by Bill on 7/23/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "AppDelegate.h"

#import "NavigationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self.window makeKeyAndVisible];
//    [self.window addSubview:UIViewController.view];
    [NSThread sleepForTimeInterval:2.0];
//    return YES;
    
    
    //Changing the storyboard interface based on iPhone/iPad
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
//        UIStoryboard *storyBoard;
//        
//        CGSize result = [[UIScreen mainScreen] bounds].size;
//        CGFloat scale = [UIScreen mainScreen].scale;
//        result = CGSizeMake(result.width *scale, result.height *scale);
//        
//        //----HERE WE SETUP FOR IPHONE4/4s/iPod----------------------
////        if(result.height == 960){
////            storyBoard = [UIStoryboard storyboardWithName:@"iPhone4_Storyboard" bundle:nil];
////            UIViewController *initViewController = [storyBoard instantiateInitialViewController];
////            [self.window setRootViewController:initViewController];
////        } else {
//            storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController *initViewController = [storyBoard instantiateInitialViewController];
//            [self.window setRootViewController:initViewController];
////        }
//        
//
//        
//    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        UIStoryboard *storyBoard;
//        
//        CGSize result = [[UIScreen mainScreen] bounds].size;
//        CGFloat scale = [UIScreen mainScreen].scale;
//        result = CGSizeMake(result.width *scale, result.height *scale);
//        storyBoard = [UIStoryboard storyboardWithName:@"iPad_Storyboard" bundle:nil];
//        UIViewController *initViewController = [storyBoard instantiateInitialViewController];
//        [self.window setRootViewController:initViewController];
//    }
//    
    
    
    
    // Override point for customization after application launch.
    
    //create navigationviewController obj
    //NavigationViewController *navController = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController" bundle:nil];
    
    //Create Ui NavigationController
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:navController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
