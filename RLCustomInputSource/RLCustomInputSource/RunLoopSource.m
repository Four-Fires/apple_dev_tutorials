//
//  RunLoopSource.m
//  RLCustomInputSource
//
//  Created by matthew on 2014-01-27.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import "RunLoopSource.h"
#import "AppDelegate.h"

@implementation RunLoopSource

- (id)init
{
    Log_Enter_Func;
    
    if (self = [super init])
    {
        CFRunLoopSourceContext context = {0, self, NULL, NULL, NULL, NULL, NULL,
            RunLoopSourceScheduleRoutine,
            RunLoopSourceCancelRoutine,
            RunLoopSourcePerformRoutine};
        runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        commands = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    Log_Enter_Func;
    
    [self invalidate];
    CFRelease(runLoopSource);
    [commands removeAllObjects];
    [commands release];

    [super dealloc];
}

- (void)addToCurrentRunLoop
{
    Log_Enter_Func;
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)invalidate
{
    Log_Enter_Func;
    
    // difference with CFRunLoopRemoveSource?
    CFRunLoopSourceInvalidate(runLoopSource);
}

- (void)sourceFired
{
    Log_Enter_Func;
    
    NSString *cmd = nil;
    
    while (YES)
    {
        @synchronized(self)
        {
            if ([commands count] == 0)
                break;
            else
            {
                cmd = [commands objectAtIndex:0];
                [commands removeObjectAtIndex:0];
            }
        }
        // do something with cmd
        if ([cmd isEqualToString:@"stopWorker"])
        {
            [AppDelegate sharedAppDelegate].stopWorkerFlag = YES;
        }
        else
        {
            NSString *reqStr = [NSString stringWithFormat:@"http://wsf.cdyne.com/WeatherWS/Weather.asmx/GetCityForecastByZIP?ZIP=%@", cmd];
            NSURL *reqUrl = [NSURL URLWithString:reqStr];
            NSString *str = [NSString stringWithContentsOfURL:reqUrl encoding:NSUTF8StringEncoding error:nil];
            str = [[[[AppDelegate sharedAppDelegate] textView] string] stringByAppendingString:[NSString stringWithFormat:@"%@\n\n\n\n\n",str]];
            [[[AppDelegate sharedAppDelegate] textView] performSelectorOnMainThread:@selector(setString:) withObject:str waitUntilDone:NO];
        }
    }
}

- (void)addCommand:(NSString*)command
{
    Log_Enter_Func;
    
    @synchronized(self)
    {
        [commands addObject:command];
    }
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    Log_Enter_Func;
    
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runloop);
}

@end

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    Log_Enter_Func;
    
    RunLoopSource* obj = (RunLoopSource*)info;
    AppDelegate* del = [AppDelegate sharedAppDelegate];
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    [del performSelectorOnMainThread:@selector(registerSource:) withObject:theContext waitUntilDone:NO];
    [theContext release];
}

void RunLoopSourcePerformRoutine (void *info)
{
    Log_Enter_Func;
    
    RunLoopSource*  obj = (RunLoopSource*)info;
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    Log_Enter_Func;
    
    RunLoopSource* obj = (RunLoopSource*)info;
    AppDelegate* del = [AppDelegate sharedAppDelegate];
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    [del performSelectorOnMainThread:@selector(removeSource:) withObject:theContext waitUntilDone:YES];
    [theContext release];
}

@implementation RunLoopContext

- (id)initWithSource:(RunLoopSource*)src andLoop:(CFRunLoopRef)loop
{
    Log_Enter_Func;
    
    if (self = [super init]) {
        _runLoop = (CFRunLoopRef)CFRetain(loop);
        _source = [src retain];
    }
    return self;
}

- (void)dealloc
{
    Log_Enter_Func;
    
    CFRelease(_runLoop);
    [_source release];
    [super dealloc];
}

@end