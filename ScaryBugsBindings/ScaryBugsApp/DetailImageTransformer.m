//
//  DetailImageTransformer.m
//  ScaryBugsApp
//
//  Created by matthew on 2013-12-17.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "DetailImageTransformer.h"

@implementation DetailImageTransformer

+(Class)transformedValueClass {
    return [NSImage class];
}

-(id)transformedValue:(id)value {
    if (value == nil) {
        return nil;
    } else {
        return [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:value]];
    }
}

@end
