//
//  AppDelegate.m
//  JuJingTianXiaGHD
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "BaseNavViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"index.html" withExtension:nil];
    NSLog(@"11%@",url);
    HomeViewController *vc = [[HomeViewController alloc]initWithWebViewFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) localURL:url];
    vc.title = @"主页2";
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}









- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
