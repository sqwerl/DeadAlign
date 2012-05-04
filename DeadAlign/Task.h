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
    IBOutlet NSLevelIndicatorCell *deadline;
    NSString *timeLeft;
    NSDate *dueDate;
    Boolean taskFinished;
    NSNumber *level;
    NSPopUpButtonCell *popup;

}



@property (copy) NSButtonCell *done;
@property (copy) NSString *taskName;
@property (copy) IBOutlet NSLevelIndicatorCell *deadline;
@property (copy) NSString *timeLeft;
@property (copy) NSDate *dueDate;
@property Boolean taskFinished;
@property (copy) NSNumber *level;
@property (copy) IBOutlet NSPopUpButtonCell *popup;




-(Boolean)isTaskFinished;
-(double)getMaxLevel;

@end
