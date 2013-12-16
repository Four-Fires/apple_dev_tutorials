//
//  FBCDMasterViewController.h
//  FailedBankCD
//
//  Created by matthew on 2013-12-15.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCDMasterViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *failedBankInfos;

@end
