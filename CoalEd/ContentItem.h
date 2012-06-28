//
//  ContentItem.h
//  CoalEd
//
//  Created by Kyle Kolpek on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@interface ContentItem : NSObject {
@private
    UIButton *button;
    NSString *html;
    NSString *text;
}
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) NSString *html;
@property (nonatomic, retain) NSString *text;
@end