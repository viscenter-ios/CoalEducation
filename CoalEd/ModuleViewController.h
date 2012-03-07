//
//  ModuleViewController.h
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleViewController : UIViewController <NSCopying> {
    UIWebView    *webContent;
    UILabel      *textContent;
    UIScrollView *scrollContent;

    NSMutableArray *xmlData;
    NSMutableArray *content;
    NSString *xmlFile;
    NSInteger moduleId;
}

@property (nonatomic, retain) IBOutlet UIWebView *webContent;
@property (nonatomic, retain) IBOutlet UILabel *textContent;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollContent;

- (id)initWithXMLFile:(NSString *)xmlFile;
- (void)loadXML:(NSString *)xmlFile;
- (void)createContent;
- (IBAction) buttonPressed:(id)sender;
@end
