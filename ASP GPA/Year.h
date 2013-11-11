//
//  Year.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/23/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Year : NSObject

@property(strong) NSString *name;
@property(strong) NSMutableArray *semesters;

-(id)initWithName:(NSString *)name Semesters:(NSMutableArray *)semesters;

@end
