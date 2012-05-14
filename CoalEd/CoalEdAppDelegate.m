//
//  CoalEdXMLProtoAppDelegate.m
//  CoalEdXMLProto
//
//  Created by Evan Kemper on 1/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoalEdAppDelegate.h"

@implementation CoalEdAppDelegate

@synthesize naviController, window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    MainViewController *mainView = [[MainViewController alloc] initWithNibName:@"MainViewController"
                                                                        bundle:nil];
    if(!mainView)
    {
        return;
    }
    
    // Setup the navigation controller and let it control the main view
    naviController = [[UINavigationController alloc] initWithRootViewController:mainView];  
    [mainView release];
    
    // Make the window display
  	[self.window setRootViewController:naviController];
	[self.window makeKeyAndVisible];
    
    // Set up the bars for the navigation controller
    [[naviController navigationBar] setTintColor:[UIColor colorWithRed:8.0/255.0 green:83.0/255.0 blue:165.0/255.0 alpha:1.0]];
  	[[naviController toolbar] setTintColor:[UIColor blueColor]];
    [naviController setToolbarHidden:YES];
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

@end
