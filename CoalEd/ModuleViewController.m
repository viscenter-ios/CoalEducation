//
//  ModuleViewController.m
//  CoalEdXMLProto
//
//  Created by Kyle Kolpek on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModuleViewController.h"

@implementation ModuleViewController

@synthesize webContent, textContent, scrollContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *rawHTML = @"<html><head></head>\
    <body style=\"margin:0;background-color:#000\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString *finalHTML = [NSString stringWithFormat:rawHTML,
                           @"http://www.youtube.com/watch?v=vhGH0jL24yU",
                           [webContent frame].size.width,
                           [webContent frame].size.height];
    [webContent loadHTMLString:finalHTML baseURL:nil];
    [textContent sizeToFit];
    [scrollContent setContentSize:CGSizeMake(900, [scrollContent frame].size.height)];
    [[webContent scrollView] setBounces:NO]; 
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

@end
