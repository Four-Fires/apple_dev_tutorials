//
//  Bug.h
//  ScaryBugsApp
//
//  Created by matthew on 2013-12-17.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bug : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * imagePath;

@end
