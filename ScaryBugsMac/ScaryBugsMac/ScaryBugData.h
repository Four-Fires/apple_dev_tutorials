//
//  ScaryBugData.h
//  ScaryBugsMac
//
//  Created by matthew on 2013-11-03.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject

@property (strong) NSString *title;
@property (assign) float rating;

- (id)initWithTitle:(NSString*)title rating:(float)rating;

@end