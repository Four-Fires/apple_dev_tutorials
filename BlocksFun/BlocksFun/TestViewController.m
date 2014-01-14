//
//  TestViewController.m
//  BlocksFun
//
//  Created by matthew on 2014-01-11.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    self.doThis = nil;
    self.doNotDoThis = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDoThis:(id)sender
{
    if (_doThis) {
        NSLog(@"_doThis block: %@", _doThis);
        _doThis();
    }
}

- (IBAction)onDoNotDo:(id)sender
{
    if (_doNotDoThis) {
        NSLog(@"_doNotDoThis block: %@", _doNotDoThis);
        _doNotDoThis();
    }
}

- (void)test6:(void (^)(void))inputBlock
{
    NSLog(@"inputBlock: %@", inputBlock);

//    _myBlock = [inputBlock copy];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"_myBlock: %@", _myBlock);
//        _myBlock();
//        [_myBlock release];
//    });

#warning this won't work
//    _myBlock = inputBlock;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"_myBlock: %@", _myBlock);
//        _myBlock();
//    });
    
#warning why this'll work?!
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"inputBlock: %@", inputBlock);
            _myBlock = [inputBlock copy];
            NSLog(@"_myBlock: %@", _myBlock);
            _myBlock();
            //        [_myBlock release];
        });
    });    
    
}

@end
