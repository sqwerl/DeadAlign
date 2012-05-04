//
//  TableViewController.m
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "Task.h"


@implementation TableViewController
@synthesize addButton;
@synthesize removeButton;


-(id)init{
    self = [super init];
    if(self){
        taskArray = [[NSMutableArray alloc] init];
        timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimeLeft) userInfo:nil repeats:YES];
//        [self setUpDatePicker];

        
    }
    return self;
}

-(void)awakeFromNib{
    [addButton setImage:[NSImage imageNamed:@"NSAddTemplate"]];
    [removeButton setImage:[NSImage imageNamed:@"NSRemoveTemplate"]];
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [taskArray count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Task *p = [taskArray objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    int units = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate:[p dueDate] options:0];
    if([identifier isEqualToString:@"deadline"]){
        NSNumber *cellLevel;

        cellLevel = [[NSNumber alloc] initWithDouble:[components day]*86400+[components hour]*86400/24+[components minute]*86400/1440+[components second]*86400/86400];
        return cellLevel;
    }else if([identifier isEqualToString:@"timeLeft"]){
        if([components month] > 0){
            return [NSString stringWithFormat:@"%d%c %d%c %d%c %d%c %d%c", [components month], 'm', [components day], 'd', [components hour], 'h', [components minute], 'm', [components second], 's'];
        }else if([components day] > 0){
            return [NSString stringWithFormat:@"%d%c %d%c %d%c %d%c", [components day], 'd', [components hour], 'h', [components minute], 'm', [components second], 's'];
        }else if([components hour] > 0){
            return [NSString stringWithFormat:@"%d%c %d%c %d%c", [components hour], 'h', [components minute], 'm', [components second], 's'];
        }else if([components minute] > 0){
            return [NSString stringWithFormat:@"%d%c %d%c", [components minute], 'm', [components second], 's'];
        }else if([components second] > 0){
            return [NSString stringWithFormat:@"%d%c", [components second], 's'];
        }
    }
    return [p valueForKey:identifier];
}

-(void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Task *p = [taskArray objectAtIndex:row];
    
    NSString *identifier = [tableColumn identifier];
    [p setValue:object forKey:identifier];
}

-(void)updateTimeLeft{
    if([taskArray count] >0){
        [taskTableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [taskArray count])] columnIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 2)]];
    }
}


-(IBAction)add:(id)sender{
    [taskArray addObject:[[Task alloc] init]];
    [taskTableView reloadData];
    [taskTableView editColumn:1 row:[taskArray count]-1 withEvent:nil select:YES];
}

-(IBAction)remove:(id)sender{
    if([taskArray count] > 0){
        NSInteger row = [taskTableView selectedRow];
        [taskTableView abortEditing];
        if(row !=-1){
            [taskArray removeObjectAtIndex:row];
        }else{
            [taskArray removeObjectAtIndex:[taskArray count]-1];
        }
        [taskTableView reloadData];
    }
}


-(IBAction)setTaskDone:(id)sender{
    Task *t = [taskArray objectAtIndex:[sender clickedRow]];

    NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
    [cb setObject:t forKey:@"t"];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(deleteSelected:) userInfo:cb repeats:NO];
}



-(IBAction)setDate:(id)sender{
    Task *t = [taskArray objectAtIndex:[taskTableView selectedRow]];
    [t setDueDate:[sender dateValue]];
}

-(void)setUpDatePicker{

	
	// create the date picker control if not created already
	if (datePicker == nil)
		datePicker = [[NSDatePicker alloc] init];
		
    
	[datePicker setEnabled:YES];
	
	
	[datePicker setDateValue: [NSDate dateWithTimeIntervalSince1970:1336806000]];	
	
	[datePicker setNeedsDisplay:YES];
//	[self updateControls];	// force update of all UI elements and the picker itself
	
	
	[datePicker setDelegate:self];
	// or we can set us as the delegate to its cell like so:
	[[datePicker cell] setDelegate:self];
	
	// we want to respond to date/time changes
	[datePicker setAction:@selector(setDate:)];
}

-(void)deleteSelected:(id)sender{
    NSDictionary *dict = [sender userInfo];
    Task *t = [dict objectForKey:@"t"];
    [taskArray removeObject:t];
    [taskTableView reloadData];
}



@end
