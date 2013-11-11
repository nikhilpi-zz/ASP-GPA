//
//  Semester.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//


#import "Semester.h"
#import "Grade.h"

@implementation Semester

@synthesize grades;
@synthesize name;
@synthesize gpa;

-(id)initWithName: (NSString*)name {
    self = [super init];
    grades = [NSMutableArray arrayWithCapacity:20];
    gpa = 0.0;
    self.name = name;
    return self;
}

-(id)initWithName:(NSString *)name Grades:(NSMutableArray*)grades GPA:(double)gpa {
    self = [super init];
    self.name = name;
    self.grades = grades;
    self.gpa = gpa;
    return self;
}

-(void)addGrade:(Grade *) grade{
    [grades addObject:grade];
}

-(void)deleteGrade:(Grade *) grade {
    [grades removeObject:grade];
}

@end
