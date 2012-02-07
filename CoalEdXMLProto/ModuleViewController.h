//
//  ModuleViewController.h
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleViewController : UIViewController {
    IBOutlet UIWebView    *webContent;
    IBOutlet UILabel      *textContent;
    IBOutlet UIScrollView *scrollContent;
}

@property (nonatomic, retain) IBOutlet UIWebView *webContent;
@property (nonatomic, retain) IBOutlet UILabel *textContent;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollContent;

@end
