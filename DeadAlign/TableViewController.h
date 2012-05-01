//
//  TableViewController.h
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewController : NSObject <NSTableViewDataSource>
{
@private
    IBOutlet NSTableView *taskTableView;
    NSMutableArray *taskArray;
    NSTimer *timer;
}

-(IBAction)add:(id)sender;

-(IBAction)remove:(id)sender;

-(IBAction)setTaskDone:(id)sender;
-(IBAction)sliderChange:(id)sender;


-(void)updateTimeLeft;
-(void)deleteSelected:(id)sender;

@end
