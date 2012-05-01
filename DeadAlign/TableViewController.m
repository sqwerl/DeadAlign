//
//  TableViewController.m
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "Task.h"
#import "CustomSliderCell.h"

@implementation TableViewController

-(id)init{
    self = [super init];
    if(self){
        taskArray = [[NSMutableArray alloc] init];
        timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimeLeft) userInfo:nil repeats:YES];
    }
    return self;
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [taskArray count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Task *p = [taskArray objectAtIndex:row];
    
    NSString *identifier = [tableColumn identifier];
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
        [taskTableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [taskArray count])] columnIndexes:[NSIndexSet indexSetWithIndex:3]];


        [taskTableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [taskArray count])] columnIndexes:[NSIndexSet indexSetWithIndex:2]];

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
    NSLog(@"%p", sender);
    Task *t = [taskArray objectAtIndex:[sender clickedRow]];

    NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
    [cb setObject:t forKey:@"t"];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(deleteSelected:) userInfo:cb repeats:NO];
}

-(IBAction)sliderChange:(id)sender{
    Task *t = [taskArray objectAtIndex:[sender clickedRow]];
    NSLog(@"%d", [[t deadline] intValue]);    
}

-(void)deleteSelected:(id)sender{
    NSDictionary *dict = [sender userInfo];
    Task *t = [dict objectForKey:@"t"];
    [taskArray removeObject:t];
    [taskTableView reloadData];
}



@end
