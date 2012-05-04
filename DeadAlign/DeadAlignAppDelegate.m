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



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    if( !flag )
        [_window makeKeyAndOrderFront:self];
    
    return YES;
}

@end
