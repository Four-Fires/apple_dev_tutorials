//
//  AppDelegate.m
//  RLCustomInputSource
//
//  Created by matthew on 2014-01-27.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize stopWorkerFlag;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    sourcesToPing = [[NSMutableArray alloc] init];
}

+ (AppDelegate*)sharedAppDelegate
{
    return [NSApplication sharedApplication].delegate;
}

- (void)registerSource:(RunLoopContext*)sourceInfo;
{
    Log_Enter_Func;
    
    [sourcesToPing addObject:sourceInfo];
}

- (void)removeSource:(RunLoopContext*)sourceInfo
{
    Log_Enter_Func;

    id objToRemove = nil;
    
    for (RunLoopContext* context in sourcesToPing)
    {
        if (context.source == sourceInfo.source)
        {
            objToRemove = context;
            break;
        }
    }
    
    if (objToRemove)
        [sourcesToPing removeObject:objToRemove];
}

- (void)workerMain:(id)data
{
    Log_Enter_Func;

    NSAutoreleasePool*  pool = [[NSAutoreleasePool alloc] init];

    stopWorkerFlag = NO;
    
    RunLoopSource *source = [[RunLoopSource alloc] init];
    [source addToCurrentRunLoop];
    [source release];
    
    do
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    while (!stopWorkerFlag);
    
    [source invalidate];
    
    [pool release];

    Log_Leaving_Func;
}


- (IBAction)startWorker:(id)sender
{
    [NSThread detachNewThreadSelector:@selector(workerMain:) toTarget:self withObject:nil];
}

- (IBAction)stopWorker:(id)sender
{
    for (RunLoopContext *context in sourcesToPing)
    {
        [context.source addCommand:@"stopWorker"];
        [context.source fireCommandsOnRunLoop:context.runLoop];
    }
}

- (void)dealloc
{
    [sourcesToPing removeAllObjects];
    [sourcesToPing release];
    [super dealloc];
}

- (IBAction)onSend:(id)sender
{
    for (RunLoopContext *context in sourcesToPing)
    {
        [context.source addCommand:[_textField stringValue]];
        [context.source fireCommandsOnRunLoop:context.runLoop];
    }
}

@end
