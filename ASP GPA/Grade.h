//
//  Grade.h
//  ASP GPA
//
//  Created by Nikhil Pai on 8/10/12.
//  Copyright (c) 2012 Nikhil Pai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grade : NSObject

@property(strong) NSString *letter;
@property(strong) NSString *sign;
@property(strong) NSString *name;
@property(assign) int band;

-(id)initWithName:(NSString*)name Letter:(NSString*)letter Sign:(NSString*)sign Band:(int) band;
@end
