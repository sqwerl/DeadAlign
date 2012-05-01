//
//  DeadAlignAppDelegate.m
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeadAlignAppDelegate.h"

@implementation DeadAlignAppDelegate

@synthesize window = _window;
@synthesize addButton;
@synthesize removeButton;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [addButton setImage:[NSImage imageNamed:@"NSAddTemplate"]];
    [removeButton setImage:[NSImage imageNamed:@"NSRemoveTemplate"]];
}

@end
