//
//  ViewController.m
//  KvoTester
//
//  Created by matthew on 2013-12-24.
//  Copyright (c) 2013 matthew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidUnload
{
    [self removeObserver:self forKeyPath:@"fullName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    BOOL automatic = NO;
    if ([key isEqualToString:@"fullName"])
        automatic = NO;
    else
        automatic = [super automaticallyNotifiesObserversForKey:key];
    return automatic;
}

- (void)setName:(FullName*)newName
{
    @synchronized(self)
    {
        if (![_fullName.firstName isEqualToString:newName.firstName] || ![_fullName.lastName isEqualToString:newName.lastName])
        {
                [self willChangeValueForKey:@"fullName"];
                NSLog(@"thread %d, willChangeValueForKey:", [[[NSThread currentThread] valueForKeyPath:@"private.seqNum"] integerValue]);
                _fullName = newName;
                [self didChangeValueForKey:@"fullName"];
                NSLog(@"thread %d, didChangeValueForKey:", [[[NSThread currentThread] valueForKeyPath:@"private.seqNum"] integerValue]);
        }
    }
}

- (IBAction)onStart:(id)sender
{
    NSArray *nameArray = @[[[FullName alloc] initWithFirst:@"Matthew" andLast:@"Li"],
                            [[FullName alloc] initWithFirst:@"Frank" andLast:@"Wang"],
                           [[FullName alloc] initWithFirst:@"Lizi" andLast:@"Song"],
                           [[FullName alloc] initWithFirst:@"Allen" andLast:@"Liu"],
                           [[FullName alloc] initWithFirst:@"Danio" andLast:@"Yuan"]];
    
    for (int i=0; i<50000; i++)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            int r = arc4random() % 5;
            [self setName:[nameArray objectAtIndex:r]];
        });

        for (int i=0; i<10; i++)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    @synchronized(self)
                    {
                        NSLog(@"thread %d, queried fullName: %@", [[[NSThread currentThread] valueForKeyPath:@"private.seqNum"] integerValue], self.fullName);
                    }
            });
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"fullName"])
    {
        NSLog(@"thread %d, observed fullName: %@", [[[NSThread currentThread] valueForKeyPath:@"private.seqNum"] integerValue], self.fullName);
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
