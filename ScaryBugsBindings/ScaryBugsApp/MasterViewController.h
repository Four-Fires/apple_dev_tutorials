//
//  MasterViewController.h
//  ScaryBugsApp
//
//  Created by Ray Wenderlich on 8/11/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BugArrayController.h"

@interface MasterViewController : NSViewController

@property (strong) NSMutableArray *bugs;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet BugArrayController *bugArrayController;
@property (strong, nonatomic) NSURL *pathToAppSupport;

@end
