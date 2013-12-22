//
//  Transaction.h
//  KVCExperiments
//
//  Created by matthew on 2013-12-21.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

-(id)initWithPayee:(NSString*)payee amount:(NSNumber*)amount andDate:(NSDate*)date;

@property (nonatomic, strong) NSString *payee;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSDate *date;

@end
