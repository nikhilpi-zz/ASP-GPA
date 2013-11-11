//
//  Grade.m
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import "Grade.h"

@implementation Grade

@synthesize name = _name;
@synthesize letter = _letter;
@synthesize band = _band;
@synthesize sign = _sign;

-(id)initWithName:(NSString*)name Letter:(NSString*)letter Sign:(NSString*)sign Band:(int)band{
    if ((self = [super init])) {
        self.name = name;
        self.letter = letter;
        self.band = band;
        self.sign = sign;
    }
    return self;
}
@end
