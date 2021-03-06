//
//  AppDelegate.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "AppDelegate.h"
#import "Parser.h"
#import "MasterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
     */
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  /*  NSArray *windows = [application windows];
    MasterViewController *main = [[[application windows]objectAtIndex:1]rootViewController];
    [Parser saveFile:main.years];
    */

    NSArray *windows = application.windows;
    UINavigationController *nav;
    for (int i = 0; i < windows.count; i++) {
        UIWindow *current = [windows objectAtIndex:i];
        if ([current.rootViewController.title isEqualToString:@"ASP GPA"]) {
            nav = (UINavigationController *)current.rootViewController;
        }
    }
    windows = nav.viewControllers;
    MasterViewController *master = [windows objectAtIndex:0];
    
    [Parser saveFile:master.years];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSArray *windows = application.windows;
    UINavigationController *nav;
    for (int i = 0; i < windows.count; i++) {
        UIWindow *current = [windows objectAtIndex:i];
        if ([current.rootViewController.title isEqualToString:@"master"]) {
            nav = (UINavigationController *)current.rootViewController;
        }
    }
    windows = nav.viewControllers;
    MasterViewController *master = [windows objectAtIndex:0];
    
    [Parser saveFile:master.years];
}

@end
