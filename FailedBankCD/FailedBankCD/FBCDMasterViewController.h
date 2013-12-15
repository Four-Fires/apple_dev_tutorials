//
//  FBCDMasterViewController.h
//  FailedBankCD
//
//  Created by matthew on 2013-12-15.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface FBCDMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
