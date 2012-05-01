//
//  Task.h
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomSliderCell;

@interface Task : NSObject
{
@private
    NSButtonCell *done;
    NSString *taskName;
    IBOutlet CustomSliderCell *deadline;
    NSString *timeLeft;
    NSDate *dueDate;
    NSTimer *timer;
    Boolean taskFinished;
    int seconds;
}

@property (copy) NSButtonCell *done;
@property (copy) NSString *taskName;
@property (copy) IBOutlet CustomSliderCell *deadline;
@property (copy) NSString *timeLeft;
@property (copy) NSDate *dueDate;
@property (copy) NSTimer *timer;
@property Boolean taskFinished;
@property int seconds;

-(void)updateTimer;
-(Boolean)isTaskFinished;

@end
