//
//  MasterViewController.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Semester.h"
#import "Year.h"
#import "Parser.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize years, isEditing,changesMade;



- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    isEditing = NO;
    changesMade = NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     years = [Parser loadFile];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editSection:)];
    self.navigationItem.leftBarButtonItem = editButton;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    self.title = @"ASP GPA";
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (changesMade) {
        [self.tableView beginUpdates];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
*/

- (void)insertNewObject:(id)sender
{
    UIAlertView *namer = [[UIAlertView alloc] initWithTitle:@"Name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done",nil];
    namer.alertViewStyle = UIAlertViewStylePlainTextInput;
    [namer show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *name= [alertView textFieldAtIndex:0].text;
        
        Semester *one = [[Semester alloc]initWithName:@"Semester 1"];
        Semester *two = [[Semester alloc]initWithName:@"Semester 2"];
        
        Year *new = [[Year alloc]initWithName:name Semesters:[NSMutableArray arrayWithObjects:one,two, nil]];
        [years insertObject:new atIndex:0];
        
        NSArray *paths = [NSArray array];
        for (int i = 0; i < new.semesters.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            paths = [paths arrayByAddingObject:indexPath];
        }
        [self.tableView beginUpdates];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        NSLog(@"years are: %i", years.count);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [[years objectAtIndex:section]name];
}


-(void)editSection:(id)sender{
    isEditing = YES;
    
    [self.tableView beginUpdates];

    NSArray *paths =[NSArray array];
    for (int sI=0; sI < [self.tableView numberOfSections]; sI++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:sI] inSection:sI];
        paths = [paths arrayByAddingObject:path];
    }
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];

    [self.tableView endUpdates];
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishEdit:)];
    self.navigationItem.leftBarButtonItem = doneButton;

}

-(void)finishEdit:(id)sender{
    isEditing = NO;
    
    [self.tableView beginUpdates];
    
    NSArray *paths =[NSArray array];
    for (int sI=0; sI < [self.tableView numberOfSections]; sI++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:([self.tableView numberOfRowsInSection:sI]-1) inSection:sI];
        paths = [paths arrayByAddingObject:path];
    }
    [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editSection:)];
    self.navigationItem.leftBarButtonItem = editButton;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
 
 UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
 headerLabel.backgroundColor = [UIColor clearColor];
 headerLabel.opaque = NO;
 headerLabel.textColor = [UIColor whiteColor];
 headerLabel.font = [UIFont boldSystemFontOfSize:30];
 headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
 
 headerLabel.text = [[years objectAtIndex:section]name]; // i.e. array element
 [customView addSubview:headerLabel];
 
 return customView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return years.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isEditing) {
        return ([[[years objectAtIndex:section] semesters]count]+1);
    }else{
    return [[[years objectAtIndex:section] semesters]count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isEditing || !(indexPath.row == ([tableView numberOfRowsInSection:indexPath.section]-1))) {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    Year *object = [years objectAtIndex:indexPath.section];
    Semester * sem = [object.semesters objectAtIndex:indexPath.row];
        cell.textLabel.text = [sem name];
        cell.detailTextLabel.text = [NSString stringWithFormat: @"%.2f", sem.gpa];

    return cell;
    }
    
    else if (isEditing && indexPath.row == ([tableView numberOfRowsInSection:indexPath.section]-1)) {
        UITableViewCell *deleteCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        deleteCell.textLabel.text = @"Delete Year";
        deleteCell.textLabel.textAlignment =  UITextAlignmentCenter;
        deleteCell.backgroundColor = [UIColor redColor];
        
        return deleteCell;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    if (isEditing && indexPath.row == ([tableView numberOfRowsInSection:indexPath.section]-1)) {
        [years removeObjectAtIndex:indexPath.section];
        [self.tableView beginUpdates];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        changesMade = YES;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        Year *currentYear = [years objectAtIndex:indexPath.section];
        [[segue destinationViewController] setCurrentSemester:[currentYear.semesters objectAtIndex:indexPath.row]];
        [[segue destinationViewController] setNamePasser:currentYear.name];
    }

}

@end
