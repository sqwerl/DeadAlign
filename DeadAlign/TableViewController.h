//
//  TableViewController.h
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewController : NSObject <NSTableViewDataSource, NSDatePickerCellDelegate>
{
    IBOutlet NSBox*			outerBox;

    IBOutlet NSTableView *taskTableView;
    NSMutableArray *taskArray;
    NSTimer *timer;
    IBOutlet NSDatePicker *datePicker;
}

@property (assign) IBOutlet NSDatePicker *datePicker;
@property (assign) IBOutlet NSButton *addButton;
@property (assign) IBOutlet NSButton *removeButton;

-(IBAction)add:(id)sender;

-(IBAction)remove:(id)sender;

-(IBAction)setTaskDone:(id)sender;
-(IBAction)setDate:(id)sender;



-(void)setUpDatePicker;

-(void)updateTimeLeft;
-(void)deleteSelected:(id)sender;

@end
