//
//  Task.m
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Task.h"

static double maxLevel = 14;

@implementation Task

@synthesize done;
@synthesize taskName;
@synthesize deadline;
@synthesize timeLeft;
@synthesize dueDate;
@synthesize taskFinished;
@synthesize level;
@synthesize popup;

-(id)init{
    self = [super init];
    if(self){
        done = [[NSButtonCell alloc] init];
        taskName = @"";
        deadline = [[NSLevelIndicatorCell alloc] init];
        dueDate = [NSDate dateWithTimeIntervalSince1970:1336762800];
        taskFinished = NO;
        popup = [[NSPopUpButtonCell alloc] init];
    }
    return self;
}



-(Boolean)isTaskFinished{
    return taskFinished;
}

-(double)getMaxLevel{
    return maxLevel;
}

@end
