//
//  FailedBankDetails.h
//  FailedBankCD
//
//  Created by matthew on 2013-12-15.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FailedBankInfo;

@interface FailedBankDetails : NSManagedObject

@property (nonatomic, retain) NSDate * closeDate;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSNumber * zip;
@property (nonatomic, retain) FailedBankInfo *info;

@end
