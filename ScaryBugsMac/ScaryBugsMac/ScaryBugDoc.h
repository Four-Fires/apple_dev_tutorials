//
//  ScaryBugDoc.h
//  ScaryBugsMac
//
//  Created by matthew on 2013-11-16.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScaryBugData.h"

@interface ScaryBugDoc : NSObject

@property (strong) ScaryBugData *data;
@property (strong) NSImage *thumbImage;
@property (strong) NSImage *fullImage;

- (id)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage;

@end
