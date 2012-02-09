//
//  MainView.h
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"

@interface MainViewController : UIViewController {
    NSMutableArray *modules;
}


-(void) loadModules:(NSString *)XMLFilePath;
-(void) createButtons;

@end
