//
//  MainViewCell.h
//  CoalEd
//
//  Created by Kyle Kolpek on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopAlignedLabel.h"

@interface MainViewCell : UITableViewCell {
    UIImageView *icon;
    TopAlignedLabel *title;
    TopAlignedLabel *description;
}
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, retain) IBOutlet TopAlignedLabel *title;
@property (nonatomic, retain) IBOutlet TopAlignedLabel *description;


@end
