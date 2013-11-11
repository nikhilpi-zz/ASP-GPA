//
//  MasterViewController.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Semester.h"
#import "Year.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSMutableArray *years;
@property(assign) BOOL *isEditing;
@property(assign) BOOL *changesMade;

-(void) loadSemesters;

@end
