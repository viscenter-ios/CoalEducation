//
//  MainView.h
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
    NSMutableArray *moduleXMLList;
    NSMutableArray *moduleVCList;
}


-(void) loadModules:(NSString *)xmlFile;
-(void) createButtons;
-(IBAction) buttonPressed:(id)sender;

@end
