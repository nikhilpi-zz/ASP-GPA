//
//  DetailViewController.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Semester.h"
#import "Grade.h"
#import "Calculator.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource ,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Semester *currentSemester;
@property (strong,nonatomic) Grade *currentGrade;
@property (strong, nonatomic) Calculator *calc;


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSString *namePasser;

@property (strong, nonatomic) IBOutlet UIPickerView *gradePicker;
@property (strong, nonatomic) IBOutlet UIButton *add;
@property (strong, nonatomic) IBOutlet UIButton *delete;
@property (strong, nonatomic) IBOutlet UIToolbar *bar;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UILabel *display;
@property (strong, nonatomic) IBOutlet UITableView *gradeTable;
@property (strong, nonatomic) IBOutlet UILabel *nameYear;
@property (strong, nonatomic) IBOutlet UILabel *nameDetail;


@property (nonatomic, strong) NSArray *bandArray;
@property (strong, nonatomic) NSArray *letterArray;
@property (strong, nonatomic) NSArray *signArray;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(void) setPickerWithGrade:(Grade*) grade;
-(IBAction)addGrade:(id)sender;
-(IBAction)doneEditting:(id)sender;
-(IBAction)deleteGrade:(id)sender;
-(IBAction)done:(id)sender;


@end
