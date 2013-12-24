//
//  ViewController.h
//  KvoTester
//
//  Created by matthew on 2013-12-24.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullName.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) FullName *fullName;

- (IBAction)onStart:(id)sender;

@end
