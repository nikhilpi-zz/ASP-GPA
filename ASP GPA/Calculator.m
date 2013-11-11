//
//  Calculator.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "Calculator.h"
#import "Grade.h"
#import "Semester.h"

@implementation Calculator


@synthesize highBand = _highBand;
@synthesize midBand = _midBand;
@synthesize lowBand = _lowBand;
@synthesize gradeRef = _gradeRef;

-(id)init {
    self = [super init];
    
    
    _highBand = [[NSArray alloc] initWithObjects:@"5.3", @"5.0", @"4.7",@"4.3", @"4.0", @"3.7", @"3.3", @"3.0", @"2.7", @"2.3", @"2.0", @"1.7", @"0.0", @"0.0",@"0.0", nil];
    
    _midBand = [[NSArray alloc] initWithObjects: @"4.8", @"4.5",@"4.2", @"3.8", @"3.5",@"3.2",@"2.8", @"2.5",@"2.2",@"1.8", @"1.5",@"1.2", @"0.0",@"0.0",@"0.0", nil];
    
    _lowBand = [[NSArray alloc] initWithObjects: @"4.3", @"4.0", @"3.7",@"3.3",@"3.0", @"2.7", @"2.3", @"2.0", @"1.7", @"1.3", @"1.0", @"0.7", @"0.0",@"0.0",@"0.0", nil];
    
    _gradeRef = [[NSArray alloc] initWithObjects:@"A+",@"A ",@"A-", @"B+",@"B ",@"B-",@"C+",@"C ",@"C-",@"D+",@"D ",@"D-",@"F+", @"F ",@"F-", nil];
    
    return self;
    
}

-(void)calculateSemester:(Semester *) semester{
    
    if (semester.grades.count != 0) {
        NSLog(@"start calc");
    double total = 0.0;
    
    for(int i = 0; i < semester.grades.count; i++) {
        Grade *current = [semester.grades objectAtIndex:i];

        int idx = 0;
        for (; ![[current.letter stringByAppendingString:current.sign] isEqual:[_gradeRef objectAtIndex:idx]]; idx++) {
        }
        
        NSString *num =nil;
        
        if (current.band == 1){
            num =[_highBand objectAtIndex:idx];
        } else if (current.band == 2){
            num =[_midBand objectAtIndex:idx];
        } else if (current.band == 3){
            num =[_lowBand objectAtIndex:idx];
        }

        total = total + [num doubleValue];
    }
    
    semester.gpa = total/semester.grades.count;
    } else
    {semester.gpa = 0.0;}
    
}



@end
