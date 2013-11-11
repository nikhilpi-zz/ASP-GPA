//
//  Semester.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grade.h"

@interface Semester : NSObject

@property(strong) NSMutableArray *grades;
@property(assign) double gpa;
@property(strong) NSString *name;

-(id)initWithName: (NSString*)name;
-(id)initWithName:(NSString *)name Grades:(NSMutableArray*)grades GPA:(double)gpa;

-(void)addGrade:(Grade *) grade;
-(void)deleteGrade:(Grade *) grade;

@end

