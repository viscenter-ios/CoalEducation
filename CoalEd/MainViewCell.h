//
//  MainViewCell.h
//  CoalEd
//
//  Created by Kyle Kolpek on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewCell : UITableViewCell {
    UIImageView *icon;
    UILabel *title;
    UILabel *description;
}
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *description;


@end
