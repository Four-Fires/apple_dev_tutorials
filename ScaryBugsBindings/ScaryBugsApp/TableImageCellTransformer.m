//
//  TableImageCellTransformer.m
//  ScaryBugsApp
//
//  Created by matthew on 2013-12-17.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "TableImageCellTransformer.h"
#import "NSImage+Extras.h"

@implementation TableImageCellTransformer

+(Class)transformedValueClass {
    return [NSImage class];
}

-(id)transformedValue:(id)value {
    if (value == nil) {
        return nil;
    } else {
        NSImage *image = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:value]];
        image = [image imageByScalingAndCroppingForSize:CGSizeMake( 44, 44 )];
        return image;
    }
}

@end
