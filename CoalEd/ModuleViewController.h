//
//  ModuleViewController.h
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TopAlignedLabel.h"

@interface ModuleViewController : UIViewController <NSCopying> {
    UIWebView       *webContent;
    UITextView *lowerTextContent;
    UITextView *upperTextContent;
    UIImageView     *lowerTextBG;
    UIImageView     *upperTextBG;
    UIImageView     *imageContent;
    UIScrollView    *scrollContent;

    NSMutableArray *xmlData;
    NSMutableArray *content;
    NSString *xmlFile;
    NSInteger moduleId;
    ModuleViewController *prev;
    ModuleViewController *next;
}
@property (nonatomic, retain) ModuleViewController *prev;
@property (nonatomic, retain) ModuleViewController *next;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *prevButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *homeButton;
@property (nonatomic, retain) IBOutlet UIWebView *webContent;
@property (nonatomic, retain) IBOutlet UITextView *lowerTextContent;
@property (nonatomic, retain) IBOutlet UITextView *upperTextContent;
@property (nonatomic, retain) IBOutlet UIImageView *lowerTextBG;
@property (nonatomic, retain) IBOutlet UIImageView *upperTextBG;
@property (nonatomic, retain) IBOutlet UIImageView *imageContent;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollContent;

- (id)initWithXMLFile:(NSString *)xmlFile;
- (void)loadXML;
- (void)createContent;
- (IBAction) buttonPressed:(id)sender;
- (IBAction)toPrev:(id)sender;
- (IBAction)toNext:(id)sender;
- (IBAction)toHome:(id)sender;
- (void)loadSub:(int)index;

- (void)loadVideo:(int)index;
- (void)loadImage:(int)index;
- (void)loadRawText:(int)index;
@end
