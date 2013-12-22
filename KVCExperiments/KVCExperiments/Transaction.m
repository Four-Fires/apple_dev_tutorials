//
//  Transaction.m
//  KVCExperiments
//
//  Created by matthew on 2013-12-21.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

-(id)initWithPayee:(NSString*)payee amount:(NSNumber*)amount andDate:(NSDate*)date
{
    if (self = [super init]) {
        self.payee = payee;
        self.amount = amount;
        self.date = date;
    }
    return self;
}


@end
