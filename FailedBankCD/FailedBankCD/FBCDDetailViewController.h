//
//  FBCDDetailViewController.h
//  FailedBankCD
//
//  Created by matthew on 2013-12-15.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCDDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
