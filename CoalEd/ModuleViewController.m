//
//  ModuleViewController.m
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModuleViewController.h"
#import "TouchXML.h"

@implementation ModuleViewController

@synthesize webContent, lowerTextContent, upperTextContent, upperTextBG, lowerTextBG, imageContent, scrollContent, prev, next, prevButton, nextButton, homeButton, toolbar, thumbView, pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithXMLFile:(NSString *)xmlFiles {
    self = [super initWithNibName:@"ModuleViewController" bundle:nil];
    prev = nil;
    next = nil;
    if (self) {
        self->xmlFile = [xmlFiles copy];
        moduleId = -1;       
    }
    return self;
}

// Change the way copy works
- (id)copyWithZone:(NSZone *)zone {
    ModuleViewController *returnObj = [super init];
    returnObj->xmlFile = [xmlFile copyWithZone:zone];
    returnObj->xmlData = [xmlData copyWithZone:zone];
    
    return returnObj;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadXML];
    [self createContent];
    [[webContent scrollView] setBounces:NO];
    [self loadSub:0];
    
    //Load background image
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPad_Background.jpg"]];
    [tmpImageView setFrame:self.view.frame]; 
    [self.view addSubview: tmpImageView];
    [self.view sendSubviewToBack: tmpImageView];
    [tmpImageView release];
    
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)];
    
    // Set up toolbar
    if(!prev && !next)
    {
        [toolbar setItems:[[NSArray alloc] initWithObjects:spacer1, homeButton, spacer2, nil] animated:NO];
    }
    else if(!prev)
    {
        [toolbar setItems:[[NSArray alloc] initWithObjects:spacer1, homeButton, spacer2, nextButton, nil] animated:NO];
    }
    else if(!next)
    {
        [toolbar setItems:[[NSArray alloc] initWithObjects:prevButton, spacer1, homeButton, spacer2, nil] animated:NO];
    }
    else
    {
        [toolbar setItems:[[NSArray alloc] initWithObjects:prevButton, spacer1, homeButton, spacer2, nextButton, nil] animated:NO];
    }
}

- (void)goHome {
[[self navigationController] popToRootViewControllerAnimated:YES];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"Upside down or Portrait");
        return  YES;
    }
    
    else {
        return NO;
    }
}

- (void)loadXML {
    
    // Initialize the modules MutableArrays
    xmlData = [[NSMutableArray alloc] init];	
    
    NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:xmlFile];
    NSData *XMLData   = [NSData dataWithContentsOfFile:XMLPath];
    CXMLDocument *fileParser = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];
    
    // Create a new Array object to be used with the looping of the results from the fileParser
    NSArray *resultNodes = NULL;
    
    // Load the module ID
    moduleId =  [[[fileParser nodeForXPath:@"//module/id" error:nil] stringValue] intValue];    
    
    // Set up the title
    [[self navigationItem] setTitle:[[fileParser nodeForXPath:@"//module/title" error:nil] stringValue]];
    
    // Set the resultNodes Array to contain an object for every instance of a node in the XML file
    resultNodes = [fileParser nodesForXPath:@"//module/content" error:nil];
    
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
        
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in modules
        NSMutableDictionary *contentItem = [[NSMutableDictionary alloc] init];
        
        // Loop through the children of the current  node
        for(int i = 0; i < [resultElement childCount]; i++) {
            
            // Add each field to the module Dictionary with the node name as key and node value as the value
            [contentItem setObject:[[resultElement childAtIndex:i] stringValue] forKey:[[resultElement childAtIndex:i] name]];
        }
        
        // Add the module to the modules array so that the view can access it.
        [xmlData addObject:[contentItem copy]];
    }
}

- (void)createContent {
    UIButton *button;
    
    //768 x 148
    // Calculate the frame of each button and the content size of the
    // scroll view
    int x,
        y,
        bWidth  = 128,
        bHeight = 128,
        xMargin = 40;
    
    if([xmlData count] <= 1) {
        [scrollContent setHidden:YES];
    }
        
    // Create a button for each content item
    for (int i=0; i<[xmlData count]; i++) {
        x = (bWidth+xMargin)*i+xMargin;
        y = ([thumbView frame].size.height-bHeight)/2;
        button = [[UIButton alloc] initWithFrame:
                                CGRectMake(x, y, bWidth, bHeight)];
        [button setImage:[UIImage imageNamed:[[xmlData objectAtIndex:i] objectForKey:@"thumbnail"]]
                forState:UIControlStateNormal];
        button.layer.cornerRadius = 10; // this value varies on desired look
        button.clipsToBounds = YES;
        [button setTag:i];
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];

        [[self thumbView] addSubview:button];
        
    }
    
[thumbView setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 723/2, 694, 768, 500)];
    
}

// Perform an action based on the tag of the sender. In this case we will
// load an HTML file.
- (IBAction) buttonPressed:(id)sender {
    [self loadSub:[sender tag]];
}

- (IBAction)toPrev:(id)sender {
    if([[[self navigationController] viewControllers] containsObject:prev]) {
        [[self navigationController] popToViewController:prev animated:YES];
        NSLog(@"Popping");
        

    }
    else {
        [[self navigationController] pushViewController:prev animated:YES];
        NSLog(@"Pushing");
    }
}

- (IBAction)toNext:(id)sender {
    if([[[self navigationController] viewControllers] containsObject:next]) {
        [[self navigationController] popToViewController:next animated:YES];
    }
    else {
        [[self navigationController] pushViewController:next animated:YES];
    }
}

- (IBAction)toHome:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)loadSub:(int) index {
    
    // Retrieve file name
    NSString *contentType;
    contentType = [[xmlData objectAtIndex:index] objectForKey:@"contentType"];
    
    // Load proper content from file
    if([contentType isEqualToString:@"video"]) {
        [self loadVideo:index];
    }
    else if([contentType isEqualToString:@"image"]) {
        [self loadImage:index];
    }
    else if([contentType isEqualToString:@"text"]) {
        [self loadRawText:index];

    }
    
    else if ([contentType isEqualToString:@"next"]) {
        [self goToNext:index];
    }
    
}

- (void)goToNext:(int)index {
    NSString *page;
    page = [[xmlData objectAtIndex:index] objectForKey:@"page"];
    
    if([[[self navigationController] viewControllers] containsObject:next]) {
        [[self navigationController] popToViewController:next animated:YES];
    }
    else {
        [[self navigationController] pushViewController:next animated:YES];
        
        NSLog(@"push");
    }

}

- (void)loadVideo:(int)index {
    NSString *url = [[NSString alloc] initWithFormat:[[xmlData objectAtIndex:index] objectForKey:@"url"]]; 
    //NSString *wast = [url stringByAppendingString :@"&autoplay=1"];
    NSString *embedHTML = [NSString stringWithFormat:@"<html>\
    <head>\
    </head>\
    <body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" \
    type=\"application/x-shockwave-flash\" width=768pt height=432pt allowfullscreen=\"false\">\
    </embed>\
    </body>\
    </html>",url];
     
                        
    
    [webContent setHidden:NO];
    [imageContent setHidden:YES];
    [webContent setBackgroundColor:[UIColor blackColor]];
    [upperTextContent setHidden:YES];
    [lowerTextContent setHidden:NO];
    lowerTextContent.userInteractionEnabled = NO;
    [upperTextBG setHidden:YES];
    [lowerTextBG setHidden:NO];
    [webContent loadHTMLString:embedHTML baseURL:nil];
    [lowerTextContent setText:[[xmlData objectAtIndex:index] objectForKey:@"description"]];  
    [webContent setAllowsInlineMediaPlayback:NO];
    
     //width=768pt height=432pt
}

         

- (void)loadImage:(int)index {
    NSString *imageFileName = [[NSString alloc] initWithFormat:[[xmlData objectAtIndex:index] 
                                                                    objectForKey:@"caption_image"]]; 
    [webContent setHidden:YES];
    [imageContent setHidden:NO];
    [upperTextContent setHidden:YES];
    [lowerTextContent setHidden:NO];
    lowerTextContent.userInteractionEnabled = NO;
    [upperTextBG setHidden:YES];
    UIImage *tempImage = [UIImage imageNamed:imageFileName];
    [imageContent setImage:tempImage];
    [lowerTextBG setHidden:NO];
    [lowerTextContent setText:[[xmlData objectAtIndex:index] objectForKey:@"description"]];    
}

- (void)loadRawText:(int)index {
    NSString *xmlTitle = [[xmlData objectAtIndex:index] objectForKey:@"title"];
    [webContent setHidden:YES];
    [imageContent setHidden:YES];
    [upperTextContent setHidden:NO];
    upperTextContent.userInteractionEnabled = NO;
    [lowerTextContent setHidden:YES];
    [upperTextBG setHidden:NO];
    [lowerTextBG setHidden:YES];
    [upperTextContent setText:[[xmlData objectAtIndex:index] objectForKey:@"description"]];
    
    if ([xmlTitle isEqualToString:@"About"]) {
        NSString *imageFileName = [[xmlData objectAtIndex:index] objectForKey:@"caption_image"];
        UIImage *tempImage = [UIImage imageNamed:imageFileName];
        [imageContent setHidden:NO];
        [imageContent setImage:tempImage];
        imageContent.frame = CGRectMake(30, 230+35, 700, 660);
        //upperTextBG.frame = CGRectMake(0, 4, 768, 350);
        //UIImage *bgImage = [UIImage imageNamed:@"TEXT_Background350.png"];
        //[upperTextBG setImage:bgImage];
        NSLog(@"Showing Image");
    }
    
    else {
        [imageContent setHidden:YES];
        NSLog(@"Not about page");
    
    }
    

}

@end
