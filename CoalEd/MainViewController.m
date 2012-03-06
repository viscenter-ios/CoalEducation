//
//  MainView.m
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "ModuleViewController.h"
#import "TouchXML.h"

@implementation MainViewController

@synthesize scrollView;

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
// fills the modules array with the entries
-(void) loadModules:(NSString *)xmlFile {
    
    // Initialize the modules MutableArrays
    moduleXMLList = [[NSMutableArray alloc] init];	
    moduleVCList  = [[NSMutableArray alloc] init];
    
    NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:xmlFile];
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
        [moduleXMLList addObject:[module copy]];
        [moduleVCList addObject:
         [[ModuleViewController alloc] initWithXMLFile:[module objectForKey:@"file"]]];
    }
}

// Creates the buttons after having loaded the modules
-(void) createButtons {
    
    // Make sure we have loaded modules
    if(!moduleXMLList || [moduleXMLList count] == 0) {
        return;
    }
    
    // Generate the positions of the buttons
    int bWidth  = 128,
        bHeight = 128,
        yMargin = 40,
        contentHeight = (yMargin+bHeight)*[moduleVCList count]+yMargin; 
    [[self scrollView] setContentSize: CGSizeMake(768, contentHeight)];
    // Create the buttons
    for(int i=0; i<[moduleXMLList count]; i++) {
        int r = i,
            x = 40,
            y = r*(yMargin+bHeight)+yMargin;
        UIButton *button = [[UIButton alloc] initWithFrame:
                            CGRectMake(x, y, bWidth, bHeight)];
        [button setImage:[UIImage imageNamed:[[moduleXMLList objectAtIndex:i] objectForKey:@"thumbnail"]]
                forState:UIControlStateNormal];
        
        // Set the tag for module access later
        // NOTE: this may have an issue with 0
        [button setTag:i];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [[self view] addSubview:button];
    }
}


-(IBAction) buttonPressed:(id)sender {
    
    ModuleViewController *module = [moduleVCList objectAtIndex:[sender tag]];
    [[self navigationController] pushViewController:module animated:YES];
}

/* -(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Make sure we are performing the right segue
    if([[segue identifier] isEqualToString:@"toModule"]) {
        ModuleViewController *mv = [segue destinationViewController];
        int tagIndex = [(UIButton *)sender tag];
        
        // TODO: Add Module initialization code here
    }
}*/

@end