//
//  FullName.m
//  KvoTester
//
//  Created by matthew on 2013-12-24.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import "FullName.h"

@implementation FullName

- (id)initWithFirst:(NSString*)first andLast:(NSString*)last
{
    if (self = [super init])
    {
        self.firstName = first;
        self.lastName = last;
    }
    return  self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@, %@", _lastName, _firstName];
}

@end
