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

@synthesize webContent, textContent, scrollContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithXMLFile:(NSString *)xmlFile {
    self = [super initWithNibName:@"ModuleViewController" bundle:nil];
    if (self) {
        self->xmlFile = [xmlFile copy];
        moduleId = -1;
    }
    return self;
}

// Change the way copy works
- (id)copyWithZone:(NSZone *)zone {
    ModuleViewController *returnObj = [super copyWithZone:zone];
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
    [self loadXML:xmlFile];
    [self createContent];
    [[webContent scrollView] setBounces:NO];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadXML:(NSString *)xmlFile {
    
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
    
    // Calculate the frame of each button and the content size of the
    // scroll view
    int x,
        y,
        bWidth  = 128,
        bHeight = 128,
        xMargin = 40;
    [scrollContent setContentSize:
     CGSizeMake((bWidth+xMargin)*[xmlData count]+xMargin, bHeight+20)];
    
    // Create a button for each content item
    for (int i=0; i<[xmlData count]; i++) {
        x = (bWidth+xMargin)*i+xMargin;
        y = ([scrollContent frame].size.height-bHeight)/2;
        button = [[UIButton alloc] initWithFrame:
                                CGRectMake(x, y, bWidth, bHeight)];
        [button setImage:[UIImage imageNamed:[[xmlData objectAtIndex:i] objectForKey:@"thumbnail"]]
                forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [[self scrollContent] addSubview:button];
    }
}

// Perform an action based on the tag of the sender. In this case we will
// load an HTML file.
- (IBAction) buttonPressed:(id)sender {
    
    // Retrieve file name
    NSString *fileName;
    fileName = [[xmlData objectAtIndex:[sender tag]] objectForKey:@"htmlFile"];
    
    // Load file with web view
    [webContent loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL fileURLWithPath:
       [[NSBundle mainBundle] pathForResource:fileName ofType:nil]isDirectory:NO]]];
    [textContent setText:[[xmlData objectAtIndex:[sender tag]] objectForKey:@"description"]];
    CGSize size = [[textContent text] sizeWithFont:[textContent font]
                                          forWidth:[textContent frame].size.width
                                     lineBreakMode:[textContent lineBreakMode]];
    [textContent setFrame:CGRectMake([textContent frame].origin.x,
                                     [textContent frame].origin.y,
                                     size.width,
                                     size.height)];
     
}
@end
