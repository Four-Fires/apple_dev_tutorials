//
//  main.cpp
//  KVCExperiments
//
//  Created by matthew on 2013-12-21.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

int main(int argc, const char * argv[])
{
    NSMutableArray *transactions = [NSMutableArray array];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 1, 2009"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@150.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 1, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@170.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 1, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Car Loan" amount:@250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 15, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Car Loan" amount:@250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 15, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Car Loan" amount:@250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Mar 15, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"General Cable" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 1, 2009"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"General Cable" amount:@155.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 1, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"General Cable" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 1, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 15, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 15, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Mar 15, 2010"]]];
    [transactions addObject:[[Transaction alloc] initWithPayee:@"Animal Hospital" amount:@600.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jul 15, 2010"]]];
    
    NSNumber *transactionAverage = [transactions valueForKeyPath:@"@avg.amount"];
    NSLog(@"transactionAverage: %@", transactionAverage);
    
    NSArray *payees1 = [transactions valueForKeyPath:@"@distinctUnionOfObjects.payee"];
    NSLog(@"distinctUnionOfObjects.payee: %@", payees1);
    
    NSArray *payees2 = [transactions valueForKeyPath:@"@unionOfObjects.payee"];
    NSLog(@"unionOfObjects.payee: %@", payees2);
    
    NSArray *payee3 = [transactions valueForKey:@"payee"];
    NSLog(@"payee: %@", payee3);
    
    NSNumber *amountSum = [transactions valueForKeyPath:@"@sum.amount"];
    NSLog(@"amountSum = %@", amountSum);
    
    NSArray *numbers = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
//    NSNumber *sum = [numbers valueForKeyPath:@"@sum"];
    NSNumber *sum = [numbers valueForKeyPath:@"@sum.self"];
    NSLog(@"sum = %@", sum);
    
    NSMutableArray *arrayOfTransactionsArrays = [NSMutableArray array];
    NSMutableArray *moreTranscations = [NSMutableArray array];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"General Cable - Cottage" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 18, 2009"]]];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"General Cable - Cottage" amount:@155.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 9, 2010"]]];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"General Cable - Cottage" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 1, 2010"]]];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"Second Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Nov 15, 2010"]]];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"Second Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Sep 20, 2010"]]];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"Second Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 12, 2010"]]];
    [moreTranscations addObject:[[Transaction alloc] initWithPayee:@"Hobby Shop" amount:@600.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jun 14, 2010"]]];

    [arrayOfTransactionsArrays addObject:transactions];
    [arrayOfTransactionsArrays addObject:moreTranscations];
    
    NSArray *payees4 = [arrayOfTransactionsArrays valueForKeyPath:@"@distinctUnionOfArrays.payee"];
    NSLog(@"@distinctUnionOfArrays.payee: %@", payees4);
    NSArray *payees5 = [arrayOfTransactionsArrays valueForKeyPath:@"@unionOfArrays.payee"];
    NSLog(@"@unionOfArrays.payee: %@", payees5);
    
    NSMutableSet *transactionSet1 = [NSMutableSet set];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 1, 2009"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@150.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 1, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@170.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 1, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Car Loan" amount:@250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 15, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Car Loan" amount:@250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 15, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Car Loan" amount:@250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Mar 15, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"General Cable" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 1, 2009"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"General Cable" amount:@155.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 1, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"General Cable" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 1, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 15, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 15, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Mar 15, 2010"]]];
    [transactionSet1 addObject:[[Transaction alloc] initWithPayee:@"Animal Hospital" amount:@600.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jul 15, 2010"]]];

    NSMutableSet *transactionSet2 = [NSMutableSet set];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"General Cable - Cottage" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 18, 2009"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"General Cable - Cottage" amount:@155.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jan 9, 2010"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"General Cable - Cottage" amount:@120.00 andDate:[NSDate dateWithNaturalLanguageString:@"Dec 1, 2010"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"Second Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Nov 15, 2010"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"Second Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Sep 20, 2010"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"Second Mortgage" amount:@1250.00 andDate:[NSDate dateWithNaturalLanguageString:@"Feb 12, 2010"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"Hobby Shop" amount:@600.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jun 14, 2010"]]];
    [transactionSet2 addObject:[[Transaction alloc] initWithPayee:@"Green Power" amount:@600.00 andDate:[NSDate dateWithNaturalLanguageString:@"Jun 14, 2010"]]];

    NSMutableSet *setOfSets = [NSMutableSet set];
    [setOfSets addObject:transactionSet1];
    [setOfSets addObject:transactionSet2];
    
    NSSet *payee6 = [setOfSets valueForKeyPath:@"@distinctUnionOfSets.payee"];
    NSLog(@"distinctUnionOfSets.payee: %@", payee6);
    
    NSMutableArray *arrayOfSets = [NSMutableArray array];
    [arrayOfSets addObject:transactionSet1];
    [arrayOfSets addObject:transactionSet2];
    NSSet *payee7 = [arrayOfSets valueForKeyPath:@"@distinctUnionOfSets.payee"];
    NSLog(@"arrayOfSets @distinctUnionOfSets.payee: %@", payee7);
    NSArray *payee8 = [arrayOfSets valueForKeyPath:@"@distinctUnionOfSets.payee"];
    NSLog(@"arrayOfSets @distinctUnionOfSets.payee: %@", payee8);

    NSArray *payee9 = [arrayOfSets valueForKeyPath:@"@distinctUnionOfArrays.payee"];
    NSLog(@"arrayOfSets @distinctUnionOfArrays.payee: %@", payee9);
    NSArray *payee10 = [arrayOfSets valueForKeyPath:@"@unionOfArrays.payee"];
    NSLog(@"arrayOfSets @unionOfArrays.payee: %@", payee10);
    
    return 0;
}

