//
//  AppDelegate.h
//  RLCustomInputSource
//
//  Created by matthew on 2014-01-27.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RunLoopSource.h"

#define Log_Enter_Func      NSLog(@"thread %@: >> %s", [[NSThread currentThread] valueForKeyPath:@"private.seqNum"], __func__)
#define Log_Leaving_Func    NSLog(@"thread %@: << %s", [[NSThread currentThread] valueForKeyPath:@"private.seqNum"], __func__)

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSMutableArray *sourcesToPing;
    BOOL stopWorkerFlag;
}

- (IBAction)onSend:(id)sender;
+ (AppDelegate*)sharedAppDelegate;

- (void)registerSource:(RunLoopContext*)sourceInfo;
- (void)removeSource:(RunLoopContext*)sourceInfo;
- (IBAction)startWorker:(id)sender;
- (IBAction)stopWorker:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSTextField *textField;
@property (assign) BOOL stopWorkerFlag;

@end
