//
//  BugArrayController.m
//  ScaryBugsApp
//
//  Created by matthew on 2013-12-18.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "BugArrayController.h"
#import "Bug.h"

@implementation BugArrayController

-(void)remove:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Delete"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Do you really want to delete this scary bug?"];
    [alert setInformativeText:@"Deleting a scary bug cannot be undone."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert setDelegate:self];
    [alert respondsToSelector:@selector(doRemove)];
    [alert beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

-(void)alertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void*)contextInfo {
    if (returnCode ==  NSAlertFirstButtonReturn) {
        // We want to remove the saved image along with the bug
        Bug *bug = [[self selectedObjects] objectAtIndex:0];
        NSString *name = [bug valueForKey:@"name"];
        if (!([name isEqualToString:@"Centipede"] || [name isEqualToString:@"Potato Bug"] || [name isEqualToString:@"Wolf Spider"] || [name isEqualToString:@"Lady Bug"])) {
            NSError *error = nil;
            NSFileManager *manager = [[NSFileManager alloc] init];
            [manager removeItemAtURL:[NSURL URLWithString:bug.imagePath] error:&error];
            
        }
        [super remove:self];
    }
}

@end
