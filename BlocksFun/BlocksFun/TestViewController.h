//
//  TestViewController.h
//  BlocksFun
//
//  Created by matthew on 2014-01-11.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
{
    void (^_myBlock)(void);
}

- (void)test6:(void (^)(void))inputBlock;

@property (strong, nonatomic) IBOutlet UILabel *testInfoLabel;
@property (nonatomic, copy) void (^doThis) (void);
@property (nonatomic, copy) void (^doNotDoThis) (void);
#warning if to use the following assign properties, app may crash!
//@property (nonatomic, assign) void (^doThis) (void);
//@property (nonatomic, assign) void (^doNotDoThis) (void);


@end
