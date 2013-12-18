//
//  MasterViewController.m
//  ScaryBugsApp
//
//  Created by Ray Wenderlich on 8/11/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import "MasterViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"
#import "EDStarRating.h"
#import <Quartz/Quartz.h>
#import "NSImage+Extras.h"
#import "Bug.h"

@interface MasterViewController ()
@property (weak) IBOutlet EDStarRating *bugRating;
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)loadView
{
    [super loadView];
    self.bugRating.starImage = [NSImage imageNamed:@"star.png"];
    self.bugRating.starHighlightedImage = [NSImage imageNamed:@"shockedface2_full.png"];
    self.bugRating.starImage = [NSImage imageNamed:@"shockedface2_empty.png"];
    self.bugRating.maxRating = 5.0;
    self.bugRating.delegate = (id<EDStarRatingProtocol>) self;
    self.bugRating.horizontalMargin = 12;
    self.bugRating.editable=NO;
    self.bugRating.displayMode=EDStarRatingDisplayFull;
    self.bugRating.rating= 0.0;
    
    // Manual Bindings
    [self.bugRating bind:@"rating" toObject:self.bugArrayController withKeyPath:@"selection.rating" options:nil];
    [self.bugRating bind:@"editable" toObject:self.bugArrayController withKeyPath:@"selection.@count" options:nil];
}


- (IBAction)changePicture:(id)sender {
    Bug *selectedBug = [self getCurrentBug];
    if (selectedBug) {
        [[IKPictureTaker pictureTaker] beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
 
}

// Create a unique string for the images
-(NSString *)createUniqueString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

-(BOOL)saveBugImage:(NSImage*)image toBug:(Bug*)bug {
    // 1. Get an NSBitmapImageRep from the image passed in
    [image lockFocus];
    NSBitmapImageRep *imgRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0.0, 0.0, [image size].width, [image size].height)];
    [image unlockFocus];
    
    // 2. Create URL to where image will be saved
    NSURL *pathToImage = [self.pathToAppSupport URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[self createUniqueString]]];
    NSData *data = [imgRep representationUsingType: NSPNGFileType properties: nil];
    
    // 3. Write image to disk, set path in Bug
    if ([data writeToURL:pathToImage atomically:NO]) {
        bug.imagePath = [pathToImage absoluteString];
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)makeOrFindAppSupportDirectory {
    BOOL isDir;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self.pathToAppSupport absoluteString] isDirectory:&isDir] && isDir) {
        return YES;
    } else {
        NSError *error = nil;
        [manager createDirectoryAtURL:self.pathToAppSupport withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error) {
            return YES;
        } else {
            NSLog(@"Error creating directory");
            return NO;
        }
    }
}

- (void) pictureTakerDidEnd:(IKPictureTaker *) picker
                 returnCode:(NSInteger) code
                contextInfo:(void*) contextInfo
{
    NSImage *image = [picker outputImage];
    if( image !=nil && (code == NSOKButton) )
    {
        if ([self makeOrFindAppSupportDirectory]) {
            Bug *bug = [self getCurrentBug];
            if (bug) {
                [self saveBugImage:image toBug:bug];
            }
        }
    }
}

-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating
{
    Bug *selectedBug = [self getCurrentBug];
    if (selectedBug) {
        selectedBug.rating = [NSNumber numberWithFloat:self.bugRating.rating];
    }
}

-(Bug*)getCurrentBug {
    if ([[self.bugArrayController selectedObjects] count] > 0) {
        return [[self.bugArrayController selectedObjects] objectAtIndex:0];
    } else {
        return nil;
    }
}

@end
