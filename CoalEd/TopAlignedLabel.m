//
//  TopAlignedLabel.m
//  CoalEd
//
//  Created by Kyle Kolpek on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopAlignedLabel.h"

@implementation TopAlignedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setText:(NSString *)text
{
    [super setText:text];
    CGSize size = [text sizeWithFont:[self font]
                            forWidth:[self frame].size.width
                       lineBreakMode:[self lineBreakMode]];
    CGPoint origin = [self frame].origin;
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
    [self sizeToFit];
}

@end
