//
//  DetailViewController.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "DetailViewController.h"
#import "Semester.h"
#import "Grade.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation DetailViewController

@synthesize currentSemester, currentGrade, calc, namePasser;

@synthesize gradePicker, textfield, add, delete, display, gradeTable, nameYear, nameDetail, bar;
@synthesize bandArray, letterArray, signArray;


//----------------------------------------Picker-----------------------------------------------------


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
    
    if (component == 0)
    {
        returnStr = [bandArray objectAtIndex:row];
    }
    else if (component == 1)
    {
        returnStr = [letterArray objectAtIndex:row];
    } else
    {
        returnStr = [signArray objectAtIndex:row];
    }
	
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
    
	if (component == 0){
		componentWidth = 60.0;	// first column size is wider to hold names
    }
    else if (component == 1)
    {
		componentWidth = 45.0;	// second column is narrower to show numbers
    }
    else
    {
        componentWidth = 45.0;
    }
    
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        return [bandArray count];
    }
    else if (component == 1)
    {
        return [letterArray count];
    } else
    {
        return [signArray count];
    }
	
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == 0)
    {currentGrade.band = row +1;
    }
    if(component == 1)
    {currentGrade.letter = [letterArray objectAtIndex:row];
    }
    if(component == 2)
    {currentGrade.sign = [signArray objectAtIndex:row];
    }
}

-(void) setPickerWithGrade:(Grade*) grade{

    textfield.text = grade.name;
    [gradePicker selectRow:(grade.band - 1) inComponent:0 animated:YES];
    
    int letIdx = 0;
    for (; ![grade.letter isEqual:[letterArray objectAtIndex:letIdx]]; letIdx++) {}
    [gradePicker selectRow:letIdx inComponent:1 animated:YES];

    int sigIdx = 0;
    for (; ![grade.sign isEqual:[signArray objectAtIndex:sigIdx]]; sigIdx++) {}
    [gradePicker selectRow:sigIdx inComponent:2 animated:YES];
}



//------------------------------TableView-------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentSemester.grades.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
 
    Grade *object = [currentSemester.grades objectAtIndex:indexPath.row];
    NSString *cellBand = [[bandArray objectAtIndex:(object.band-1)] stringByAppendingString:@" "];
    NSString *full = [object.letter stringByAppendingString:object.sign];
    cell.textLabel.text = [cellBand stringByAppendingString:object.name];
    cell.detailTextLabel.text = full;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:20.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:20.0];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [currentSemester.grades removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentGrade = [currentSemester.grades objectAtIndex:indexPath.row];
    [self setPickerWithGrade:currentGrade];

    [add removeTarget:self action:@selector(addGrade:) forControlEvents:UIControlEventTouchUpInside];
    [add addTarget:self action:@selector(doneEditting:) forControlEvents:UIControlEventTouchUpInside];
    [delete setEnabled:YES];
    [add setTitle:@"Done" forState:UIControlStateNormal];
    
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */





//------------------------------Tool bar----------------------------------------------------

-(IBAction)addGrade:(id)sender{
    currentGrade.name = textfield.text;
    NSLog(@"added %@", currentGrade.name);
    [textfield resignFirstResponder];
    [currentSemester addGrade:currentGrade];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(currentSemester.grades.count-1) inSection:0];
    
    [gradeTable beginUpdates];
   [gradeTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [gradeTable endUpdates];
    
    currentGrade = [[Grade alloc] initWithName:@"" Letter:@"C" Sign:@" " Band:2];
    [self setPickerWithGrade:currentGrade];
    [calc calculateSemester:currentSemester];
    display.text = [NSString stringWithFormat:@" %.2f",currentSemester.gpa];
    

}


-(IBAction)deleteGrade:(id)sender{
    NSIndexPath *item = [gradeTable indexPathForSelectedRow];
    [currentSemester.grades removeObjectAtIndex:item.row];
    [gradeTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:item] withRowAnimation:UITableViewRowAnimationAutomatic];
    [delete setTintColor:[UIColor colorWithRed:.6 green:.3 blue:.3 alpha:1 ]];
    [delete setEnabled:NO];
    [add removeTarget:self action:@selector(doneEditting:) forControlEvents:UIControlEventTouchUpInside];
    [add addTarget:self action:@selector(addGrade:) forControlEvents:UIControlEventTouchUpInside];
    [add setTitle:@"Add" forState:UIControlStateNormal];
    currentGrade = [[Grade alloc] initWithName:@"" Letter:@"C" Sign:@" " Band:2];
    [self setPickerWithGrade:currentGrade];
    [calc calculateSemester:currentSemester];
    display.text = [NSString stringWithFormat:@" %.2f",currentSemester.gpa];
}

-(IBAction)doneEditting:(id)sender{
    currentGrade.name = textfield.text;
    [add removeTarget:self action:@selector(doneEditting:) forControlEvents:UIControlEventTouchUpInside];
    [add addTarget:self action:@selector(addGrade:) forControlEvents:UIControlEventTouchUpInside];
    [delete setEnabled:NO];
    [add setTitle:@"Add" forState:UIControlStateNormal];
    [gradeTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:gradeTable.indexPathForSelectedRow] withRowAnimation:UITableViewRowAnimationAutomatic];
    [gradeTable deselectRowAtIndexPath:gradeTable.indexPathForSelectedRow animated:YES];
    currentGrade = [[Grade alloc] initWithName:@"" Letter:@"C" Sign:@" " Band:2];
    [self setPickerWithGrade:currentGrade];
    [calc calculateSemester:currentSemester];
    display.text = [NSString stringWithFormat:@" %.2f",currentSemester.gpa];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textfield resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    NSLog(@"called");
    return CGRectInset( bounds , 10 , 10 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    NSLog(@"called2");
    return CGRectInset( bounds , 10 , 10 );
}

//-------------------------------------------------------------------------

-(IBAction)done:(id)sender{
  
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;

    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    currentGrade = [[Grade alloc] initWithName:@"" Letter:@"C" Sign:@" " Band:2];
    self.bandArray = [NSArray arrayWithObjects:
                      @"5.3", @"4.8", @"4.3",
                      nil];
    self.letterArray = [NSArray arrayWithObjects:
                        @"A", @"B", @"C", @"D", @"F",
                        nil];
    self.signArray = [NSArray arrayWithObjects:
                      @"+", @" ", @"-",
                      nil];
    
    calc = [[Calculator alloc] init];
    [textfield setReturnKeyType:UIReturnKeyDone];
    [self setPickerWithGrade:currentGrade];

    [delete setTintColor:[UIColor colorWithRed:.6 green:.3 blue:.3 alpha:1 ]];
    [delete setEnabled:NO];
    
    NSLog(@"name is %@",namePasser);
    
    nameYear.text = namePasser;
    nameDetail.text = currentSemester.name;
    display.text =  [NSString stringWithFormat:@" %.2f",currentSemester.gpa];
    
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    delete.adjustsImageWhenDisabled = YES;
    [delete setEnabled:NO];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}



@end
