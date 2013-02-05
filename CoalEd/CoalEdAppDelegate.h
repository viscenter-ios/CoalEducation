//
//  CoalEdXMLProtoAppDelegate.h
//  CoalEdXMLProto
//
//  Created by Evan Kemper on 1/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface CoalEdAppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *naviController;
    UIBarButtonItem *home;
}
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *naviController;

@end
