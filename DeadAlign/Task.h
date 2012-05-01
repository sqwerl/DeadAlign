//
//  Task.h
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
{
@private
    NSButtonCell *done;
    NSString *taskName;
    NSSliderCell *deadline;
    NSString *timeLeft;
    NSDate *dueDate;
    NSTimer *timer;
    Boolean taskFinished;
}

@property (copy) NSButtonCell *done;
@property (copy) NSString *taskName;
@property (copy) NSSliderCell *deadline;
@property (copy) NSString *timeLeft;
@property (copy) NSDate *dueDate;
@property (copy) NSTimer *timer;
@property Boolean taskFinished;


-(void)updateTimer;
-(Boolean)isTaskFinished;

@end
