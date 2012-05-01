//
//  Task.m
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize done;
@synthesize taskName;
@synthesize deadline;
@synthesize timeLeft;
@synthesize dueDate;
@synthesize timer;
@synthesize taskFinished;


-(id)init{
    self = [super init];
    if(self){
        done = [[NSButtonCell alloc] init];
        taskName = @"";
        deadline = [[NSSliderCell alloc] init];
        dueDate = [NSDate dateWithTimeIntervalSince1970:1336806000];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        taskFinished = NO;
        
    }
    return self;
}

-(void)updateTimer
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    int units = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate:dueDate options:0];
    if([components month] > 0){
        timeLeft = [NSString stringWithFormat:@"%d%c %d%c %d%c %d%c %d%c", [components month], 'm', [components day], 'd', [components hour], 'h', [components minute], 'm', [components second], 's'];
    }else if([components day] > 0){
        timeLeft = [NSString stringWithFormat:@"%d%c %d%c %d%c %d%c", [components day], 'd', [components hour], 'h', [components minute], 'm', [components second], 's'];
    }else if([components day] > 0){
        timeLeft = [NSString stringWithFormat:@"%d%c %d%c %d%c", [components hour], 'h', [components minute], 'm', [components second], 's'];
    }
    
}



-(Boolean)isTaskFinished{
    return taskFinished;
}
@end
