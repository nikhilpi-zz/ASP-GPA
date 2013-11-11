//
//  Parser.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/25/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grade.h"
#import "Semester.h"
#import "Year.h"

@interface Parser : NSObject


+(void)saveFile:(NSArray *)years;
+(NSMutableArray *)loadFile;

@end
