//
//  AppDelegate.m
//  ScaryBugsApp
//
//  Created by Ray Wenderlich on 8/11/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import "AppDelegate.h"
#include "MasterViewController.h"
#import "ScaryBugDoc.h"
#import "Bug.h"

@interface  AppDelegate()
@property (nonatomic,strong) IBOutlet MasterViewController *masterViewController;
@end

@implementation AppDelegate
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

-(void)prePopulate {
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"sb_FirstRun"]) {
        NSString *file = @"file://";
        NSManagedObject *centipede = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Bug" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext];
        [centipede setValue:[NSNumber numberWithFloat:3] forKey:@"rating"];
        [centipede setValue:@"Centipede" forKey:@"name"];
        [centipede setValue:[file stringByAppendingString:[[NSBundle mainBundle] pathForImageResource:@"centipede.jpg"]] forKey:@"imagePath"];
        
        NSManagedObject *potatoBug = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Bug" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext];
        [potatoBug setValue:[NSNumber numberWithFloat:4] forKey:@"rating"];
        [potatoBug setValue:@"Potato Bug" forKey:@"name"];
        [potatoBug setValue:[file stringByAppendingString:[[NSBundle mainBundle] pathForImageResource:@"potatoBug.jpg"]] forKey:@"imagePath"];
        
        NSManagedObject *wolfSpider = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Bug" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext];
        [wolfSpider setValue:[NSNumber numberWithFloat:5] forKey:@"rating"];
        [wolfSpider setValue:@"Wolf Spider" forKey:@"name"];
        [wolfSpider setValue:[file stringByAppendingString:[[NSBundle mainBundle] pathForImageResource:@"wolfSpider.jpg"]] forKey:@"imagePath"];
        
        NSManagedObject *ladyBug = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Bug" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext];
        [ladyBug setValue:[NSNumber numberWithFloat:1] forKey:@"rating"];
        [ladyBug setValue:@"Lady Bug" forKey:@"name"];
        [ladyBug setValue:[file stringByAppendingString:[[NSBundle mainBundle] pathForImageResource:@"ladybug.jpg"]] forKey:@"imagePath"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"sb_FirstRun"];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // 1. Create the master View Controller
    self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    // 2. Add the view controller to the Window's content view
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
    
    self.masterViewController.managedObjectContext = self.managedObjectContext;
    
    self.masterViewController.pathToAppSupport = [self applicationFilesDirectory];
    [self prePopulate];
}


// Added for Core Data
// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.razeware.ScaryBugsApp" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"com.razeware.ScaryBugsApp"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ScaryBugsApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![[properties valueForKey:NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"ScaryBugsApp.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

-(IBAction)resetBugs:(id)sender {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Bug"];
    NSError *error;
    NSArray *allBugs = [self.managedObjectContext executeFetchRequest:request error:&error];
    for (Bug *bug in allBugs) {
        [self.managedObjectContext deleteObject:bug];
    }
    if (!error) {
        [self saveAction:self];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"sb_FirstRun"];
        [self prePopulate];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        
        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    
    return NSTerminateNow;
}


@end
