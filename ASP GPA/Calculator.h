//
//  Calculator.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Semester.h"

@interface Calculator : NSObject




@property(strong) NSArray *highBand;
@property(strong) NSArray *midBand;
@property(strong) NSArray *lowBand;
@property(strong) NSArray *gradeRef;


-(void)calculateSemester:(Semester *)semester;
@end
