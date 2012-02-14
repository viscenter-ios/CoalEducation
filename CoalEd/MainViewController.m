//
//  MainView.m
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadModules:@"modules.xml"];
        [self createButtons];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // Show the navigation controllers after the root view
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[self navigationController] setToolbarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setHidesBackButton:YES];
    [self loadModules:@"modules.xml"];
    [self createButtons];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// loadModules function that takes a string (XMLFilePath) as a parameter and
// fills the global modules array with the entries
-(void) loadModules:(NSString *)XMLFilePath {
    
    // Initialize the modules MutableArray
    modules = [[NSMutableArray alloc] init];	
    
    NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:XMLFilePath];
    NSData *XMLData   = [NSData dataWithContentsOfFile:XMLPath];
    CXMLDocument *fileParser = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];
    
    // Create a new Array object to be used with the looping of the results from the fileParser
    NSArray *resultNodes = NULL;
    
    // Set the resultNodes Array to contain an object for every instance of a node in the XML file
    resultNodes = [fileParser nodesForXPath:@"//modules/module" error:nil];
    
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
        
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in modules
        NSMutableDictionary *module = [[NSMutableDictionary alloc] init];
        
        // Loop through the children of the current  node
        for(int i = 0; i < [resultElement childCount]; i++) {
            
            // Add each field to the module Dictionary with the node name as key and node value as the value
            [module setObject:[[resultElement childAtIndex:i] stringValue] forKey:[[resultElement childAtIndex:i] name]];
        }
        
        // Add the module to the modules array so that the view can access it.
        [modules addObject:[module copy]];
    }
}

// Creates the buttons after having loaded the modules
-(void) createButtons {
    
    // Make sure we have loaded modules
    if(!modules || [modules count] == 0)
    {
        return;
    }
    
    int bWidth  = 128,
        bHeight = 128,
        sWidth  = [[UIScreen mainScreen] bounds].size.width,
        sHeight = [[UIScreen mainScreen] bounds].size.height,
        xMargin = (sWidth-3*bWidth)/4,
        yMargin = (sHeight-3*bHeight)/(3+1); // TODO: Fix this to be based off [modules count]
    for(int i=0; i<[modules count]; i++)
    {
        int c = i%3,
            r = i/3,
            x = c*(xMargin+bWidth)+xMargin,
            y = r*(yMargin+bHeight)+yMargin;
        UIButton *button = [[UIButton alloc] initWithFrame:
                            CGRectMake(x, y, bWidth, bHeight)];
        [button setImage:[UIImage imageNamed:[[modules objectAtIndex:i] objectForKey:@"thumbnail"]]
                forState:UIControlStateNormal];
        [[self view] addSubview:button];
    }
    
    
}

@end
