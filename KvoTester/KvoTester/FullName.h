//
//  FullName.h
//  KvoTester
//
//  Created by matthew on 2013-12-24.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FullName : NSObject

- (id)initWithFirst:(NSString*)first andLast:(NSString*)last;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end
