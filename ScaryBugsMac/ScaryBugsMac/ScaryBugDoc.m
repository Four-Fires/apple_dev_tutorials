//
//  ScaryBugDoc.m
//  ScaryBugsMac
//
//  Created by matthew on 2013-11-16.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import "ScaryBugDoc.h"

@implementation ScaryBugDoc

- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage {
    if ((self = [super init])) {
        self.data = [[ScaryBugData alloc] initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
