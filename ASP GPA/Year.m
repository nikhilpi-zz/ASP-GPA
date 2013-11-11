//
//  Year.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/23/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "Year.h"

@implementation Year

@synthesize name = _name;
@synthesize semesters = _semesters;


-(id)initWithName:(NSString *)name Semesters:(NSMutableArray *)semesters{
    self = [super init];
    _semesters = semesters;
    _name = name;
    return self;
}


@end
