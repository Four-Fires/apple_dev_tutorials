//
//  ScaryBugData.m
//  ScaryBugsMac
//
//  Created by matthew on 2013-11-03.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

- (id)initWithTitle:(NSString*)title rating:(float)rating {
    if ((self = [super init])) {
        self.title = title;
        self.rating = rating;
    }
    return self;
}

@end
