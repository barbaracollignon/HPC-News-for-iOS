//
//  HPCNews_testAppDelegate.m
//  HPC News
//
//  Created by Barbara Collignon on 10/10/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCNews_testAppDelegate.h"
#import "RootViewController.h"
#import "Favorites.h"
#import "NewsFeed.h"
#import "NewsFeedWire.h"
#import "NewsBData.h"

@implementation HPCNews_testAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Favorites *myfavorites = [[Favorites alloc] init];
    NewsFeed *mynewsfeed = [[NewsFeed alloc] init];
    NewsFeedWire *mynewsfeedWire = [[NewsFeedWire alloc] init];
    NewsBData *mynewsBData = [[NewsBData alloc] init] ;
    
    RootViewController *myroot = [[RootViewController alloc] init];
    UINavigationController *navig1 = [[UINavigationController alloc] initWithRootViewController:myroot];
    UINavigationController *navig2 = [[UINavigationController alloc] initWithRootViewController:myfavorites];
    UINavigationController *navig3 = [[UINavigationController alloc] initWithRootViewController:mynewsfeed];
  
    UINavigationController *navig32 = [[UINavigationController alloc] initWithRootViewController:mynewsfeedWire];
    
    UINavigationController *navig4 = [[UINavigationController alloc] initWithRootViewController:mynewsBData];
  
    NSArray* controllers = [NSArray arrayWithObjects:navig1,navig3,navig4,navig32,navig2,nil];
    
    _tabBarController.viewControllers = controllers;
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:0];
    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Stories" image:[UIImage imageNamed:@"09-chat-2.png"] tag:0]; 
    UITabBarItem *tabBarItem3 =  [[UITabBarItem alloc] initWithTitle:@"Random" image:[UIImage imageNamed:@"56-cloud.png"] tag:0];
    UITabBarItem *tabBarItem5 =  [[UITabBarItem alloc] initWithTitle:@"BigData" image:[UIImage imageNamed:@"64-zap.png"] tag:0];
      
    navig1.tabBarItem=tabBarItem;
    navig3.tabBarItem=tabBarItem2;
    navig2.tabBarItem=tabBarItem4;
    navig32.tabBarItem=tabBarItem3;
    navig4.tabBarItem=tabBarItem5;
    
    [myfavorites release];
    [mynewsfeed release];
    [mynewsfeedWire release];
    [mynewsBData release] ;
    [myroot release];
    [navig1 release];
    [navig2 release];
    [navig3 release];
    [navig32 release];
    [navig4 release];
    [tabBarItem release];
    [tabBarItem2 release];
    [tabBarItem4 release]; 
    [tabBarItem3 release]; 
    [tabBarItem5 release];
    
    _tabBarController.viewControllers = controllers;
  
    
    
    
    
    
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
   
  //  [_navigationController release];
    [super dealloc];
}

@end
