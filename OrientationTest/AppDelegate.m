//
//  AppDelegate.m
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ShelfViewController.h"
#import "MagazineViewController.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


#define MODAL

@interface AppDelegate () <ShelfViewControllerDelegate, MagazineViewControllerDelegate>

@end

@implementation AppDelegate {
    UIWindow *_window;
    RootViewController *_rootViewController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    _rootViewController = [RootViewController new];
    _window.rootViewController = _rootViewController;

    ShelfViewController *shelfViewController = [ShelfViewController new];
    shelfViewController.delegate = self;

    [self navigateToController:shelfViewController];

    return YES;
}

- (void)navigateToController:(UIViewController *)toController
{
    toController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    toController.modalPresentationStyle = UIModalPresentationFullScreen;
    
#ifdef MODAL
    if (_rootViewController.presentedViewController)
        [_rootViewController dismissViewControllerAnimated:YES completion:nil];
    [_rootViewController presentViewController:toController animated:YES completion:nil];
#else
    [_rootViewController displayViewController:toController completion:^{
//        _window.rootViewController = nil;
//        _window.rootViewController = _rootViewController;
    }];
    
//    _window.rootViewController = nil;
//    _window.rootViewController = _rootViewController;
#endif
}

- (void)shelfView:(ShelfViewController *)controller didSelectMagazineModel:(MagazineModel *)magazineModel
{
    MagazineViewController *magazineViewController = [MagazineViewController new];
    magazineViewController.magazineModel = magazineModel;
    magazineViewController.delegate = self;

    [self navigateToController:magazineViewController];
}

- (void)magazineViewWasClosed:(MagazineViewController *)controller
{
    ShelfViewController *shelfViewController = [ShelfViewController new];
    shelfViewController.delegate = self;

    [self navigateToController:shelfViewController];
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
