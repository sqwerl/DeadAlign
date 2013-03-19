//
//  TableViewController.m
//  DeadAlign
//
//  Created by Admin on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "Task.h"
#define BasicTableViewDragAndDropDataType @"BasicTableViewDragAndDropDataType"



@implementation TableViewController
@synthesize addButton;
@synthesize removeButton;


-(id)init{
    self = [super init];
    if(self){
        taskArray = [[NSMutableArray alloc] init];
        timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimeLeft) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [addButton setImage:[NSImage imageNamed:@"NSAddTemplate"]];
    [removeButton setImage:[NSImage imageNamed:@"NSRemoveTemplate"]];
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    [components setHour: 14];
    [components setMinute: 0];
    [components setSecond: 0];
    
    NSDate *newDate = [gregorian dateFromComponents: components];
    [_datePicker setDateValue:newDate];
    
    [taskTableView registerForDraggedTypes:[NSArray arrayWithObjects:BasicTableViewDragAndDropDataType, nil]];

}

- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rows toPasteboard:(NSPasteboard*)pboard {
    // Drag and drop support


    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rows];
    [pboard declareTypes:[NSArray arrayWithObject:BasicTableViewDragAndDropDataType] owner:self];
    [pboard setData:data forType:BasicTableViewDragAndDropDataType];

    
    return YES;
}

- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op {
    // Add code here to validate the drop
    NSLog(@"validate Drop");
    return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView*)tv acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)op {
    
    // Add code here to accept the drop
    NSPasteboard *pboard = [info draggingPasteboard];
    NSData *data = [pboard dataForType:BasicTableViewDragAndDropDataType];
    


    id rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSUInteger fromRow = [rowIndexes firstIndex];
    
    Task *t = [taskArray objectAtIndex:fromRow];
    [taskArray insertObject:t atIndex:row];
    
    if (fromRow > row) {
        fromRow = fromRow + 1;
    }
    [taskArray removeObjectAtIndex:fromRow];
    
    
    [taskTableView reloadData];
    
    [pboard clearContents];
    
    return YES;
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
            return [NSString stringWithFormat:@"%lu%c %lu%c %lu%c %lu%c %lu%c", (long)[components month], 'm', (long)[components day], 'd', (long)[components hour], 'h', (long)[components minute], 'm', (long)[components second], 's'];
        }else if([components day] > 0){
            return [NSString stringWithFormat:@"%lu%c %lu%c %lu%c %lu%c", (long)[components day], 'd', (long)[components hour], 'h', (long)[components minute], 'm', (long)[components second], 's'];
        }else if([components hour] > 0){
            return [NSString stringWithFormat:@"%lu%c %lu%c %lu%c", (long)[components hour], 'h', (long)[components minute], 'm', (long)[components second], 's'];
        }else if([components minute] > 0){
            return [NSString stringWithFormat:@"%lu%c %lu%c", (long)[components minute], 'm', (long)[components second], 's'];
        }else if([components second] > 0){
            return [NSString stringWithFormat:@"%lu%c", (long)[components second], 's'];
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



-(void)deleteSelected:(id)sender{
    NSDictionary *dict = [sender userInfo];
    Task *t = [dict objectForKey:@"t"];
    [taskArray removeObject:t];
    [taskTableView reloadData];
}



@end
