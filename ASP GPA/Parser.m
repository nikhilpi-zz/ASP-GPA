//
//  Parser.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/25/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "Parser.h"
#import "Grade.h"
#import "Semester.h"
#import "Year.h"

@implementation Parser

+(NSMutableArray *)loadFile{
    
    
    
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
    
    NSLog(@"so we got this far");
    
    NSArray *yearsArray = [temp objectForKey:@"Years"];
    NSMutableArray *years = [NSMutableArray array];
    
    if (years.count == 0) {
        NSDate *today = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *weekdayComponents =
        [gregorian components:NSYearCalendarUnit fromDate:today];
        int year = [weekdayComponents year];
        
        NSString *name = [NSString stringWithFormat:@"%i",year];
        
        Semester *one = [[Semester alloc]initWithName:@"Semester 1"];
        Semester *two = [[Semester alloc]initWithName:@"Semester 2"];
        
        Year *new = [[Year alloc]initWithName:name Semesters:[NSMutableArray arrayWithObjects:one,two, nil]];
        [years insertObject:new atIndex:0];
        
        return years;
    }
    
    for (int yI = 0; yI< yearsArray.count; yI++) {
        NSDictionary *yearDict = [NSDictionary dictionaryWithDictionary:[yearsArray objectAtIndex:yI]];
        NSString *yearName = [yearDict objectForKey:@"Name"];
        
        NSArray *semestersArray = [yearDict objectForKey:@"Semesters"];
        NSArray *yearSemesters = [NSArray array];
        for (int sI = 0; sI < semestersArray.count; sI++) {
            NSDictionary *semesterDict = [NSDictionary dictionaryWithDictionary:[semestersArray objectAtIndex:sI]];
            NSString *semesterName = [semesterDict objectForKey:@"Name"];
            NSNumber *semesterGpa = [semesterDict objectForKey:@"GPA"];
            
            NSArray *gradesArray = [semesterDict objectForKey:@"Grades"];
            NSArray *semesterGrades = [NSArray array];
            for (int gI = 0; gI < gradesArray.count; gI++) {
                NSDictionary *gradeDict = [NSDictionary dictionaryWithDictionary:[gradesArray objectAtIndex:gI]];
                NSString *gradeName = [gradeDict objectForKey:@"Name"];
                NSNumber *gradeBand = [gradeDict objectForKey:@"Band"];
                NSString *gradeLetter = [gradeDict objectForKey:@"Letter"];
                NSString *gradeSign = [gradeDict objectForKey:@"Sign"];
                Grade *newGrade = [[Grade alloc] initWithName:gradeName Letter:gradeLetter Sign:gradeSign Band:[gradeBand intValue]];
                semesterGrades = [semesterGrades arrayByAddingObject:newGrade];
                
                NSLog(@"Added grade: %@",gradeName);
            }
            
            Semester *newSemester =[[Semester alloc] initWithName:semesterName Grades:[NSMutableArray arrayWithArray:semesterGrades] GPA:[semesterGpa doubleValue]];
            yearSemesters = [yearSemesters arrayByAddingObject:newSemester];
            
            NSLog(@"Added semester: %@",semesterName);
        }
        
        Year *newYear = [[Year alloc] initWithName:yearName Semesters:[NSMutableArray arrayWithArray:yearSemesters]];
        [years addObject:newYear];
        
        NSLog(@"Added year: %@",yearName);
    }
        
    
    
    
    return years;
}


+(void)saveFile:(NSArray *)years{
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    NSLog(@"length %i",years.count);
    NSArray *yearsD = [NSArray array];
    
    for(int yI = 0; yI<years.count; yI++) {
        Year *currentYear = [years objectAtIndex:yI];
        NSLog(@"adding year %@",currentYear.name);
        NSArray *semesters = [NSArray array];
        
        for (int sI = 0; sI< currentYear.semesters.count;sI++) {
            Semester *currentSemester = [currentYear.semesters objectAtIndex:sI];
            NSLog(@"adding semester %@", currentSemester.name);
            NSArray *grades = [NSArray array];
            
            for (int gI = 0; gI<currentSemester.grades.count; gI++) {
                Grade *currentGrade = [currentSemester.grades objectAtIndex:gI];
                NSLog(@"adding grade %@", currentGrade.name);
                
                NSDictionary *gradeDict = [NSDictionary dictionaryWithObjects:
                                           [NSArray arrayWithObjects: currentGrade.name, [NSNumber numberWithInt:currentGrade.band], currentGrade.letter, currentGrade.sign, nil]
                                                                      forKeys:[NSArray arrayWithObjects: @"Name",@"Band",  @"Letter", @"Sign", nil]];
                grades =[grades arrayByAddingObject:gradeDict];
            }
            NSLog(@"Done adding grades");

            NSDictionary *semesterDict = [NSDictionary dictionaryWithObjects:
                                                                             [NSArray arrayWithObjects: currentSemester.name, [NSNumber numberWithDouble:currentSemester.gpa], grades,  nil]
                                                                     forKeys:[NSArray arrayWithObjects: @"Name", @"GPA", @"Grades", nil]];
            semesters = [semesters arrayByAddingObject:semesterDict];
        }
        
        NSDictionary *yearDict = [NSDictionary dictionaryWithObjects:
                                      [NSArray arrayWithObjects: currentYear.name, semesters, nil]
                                                                 forKeys:[NSArray arrayWithObjects: @"Name", @"Semesters", nil]];
        yearsD= [yearsD arrayByAddingObject:yearDict];
    }
    
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject: yearsD
                                                          forKey:@"Years"];
    
    
    
    
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"Saved");
    }
    else {
        NSLog(@"%@",error);
    }
   
}

@end
