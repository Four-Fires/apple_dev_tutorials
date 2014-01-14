//
//  MainViewController.m
//  BlocksFun
//
//  Created by matthew on 2014-01-11.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import "MainViewController.h"
#import "TestViewController.h"

@interface MainViewController ()
{
    NSString *_iVarStr;
}

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    // Configure the cell...
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
                cell.textLabel.text = [NSString stringWithFormat:@"Test %ld", (long)indexPath.row+1];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *testVC;
    __block TestViewController* bTestVC;
    id bIVarStr;
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                testVC = [[TestViewController alloc] init];
                testVC.doThis = ^{
#warning if we don't use local variable as in the following line, block will be NSGlobalBlock
                    printf("------- start test %ld do's\n", (long)indexPath.row+1);
//                    printf("------- start of do's\n");
                    
                    void (^blockArray[3])(void);  // an array of 3 block references
                    int i;
                    NSNumber *num1;
                    __block NSNumber *num2;
                    for (i = 0; i < 3; ++i) {
                        num1 = [NSNumber numberWithInt:i];
                        num2 = [NSNumber numberWithInt:i];
                        blockArray[i] = [^{
                            printf("hello,  %d\n", i);
                            printf("num1 is %d\n", [num1 intValue]);
                            printf("num2 is %d\n", [num2 intValue]);
                        } copy];
                    }
                    for (int i=0; i<3; i++) {
                        blockArray[i]();
                        [blockArray[i] release];
                    }
                    
                    void (^block)(void);
                    i = arc4random()%10;
                    printf("number: %d\n", i);
                    if (i > 5) {
                        block = [^{
                            printf("big number: %d\n", i);
                        } copy];
                    }
                    else
                    {
                        block = [^{
                            printf("small number: %d\n", i);
                        } copy];
                    }
                    block();
                    [block release];
                    printf("------- end of do's\n\n\n");
                };
                testVC.doNotDoThis = ^{
                    printf("------- start test %ld not do's\n", (long)indexPath.row+1);   // if we don't use local variable as in this line, block will be NSGlobalBlock
//                    printf("------- start of not do's\n");
                    void (^blockArray[3])(void);  // an array of 3 block references
                    int i;
                    NSNumber *num1;
                    __block NSNumber *num2;
                    for (i = 0; i < 3; ++i) {
                        num1 = [NSNumber numberWithInt:i];
                        num2 = [NSNumber numberWithInt:i];
                        blockArray[i] = ^{
                            printf("hello,  %d\n", i);
                            printf("num1 is %d\n", [num1 intValue]);
                            printf("num2 is %d\n", [num2 intValue]);
                        };
                        // WRONG: The block literal scope is the "for" loop.
                    }
                    for (int i=0; i<3; i++) {
                        blockArray[i]();
                    }
                    
                    void (^block)(void);
                    i = arc4random()%10;
                    printf("number: %d\n", i);
                    if (i > 5) {
                        block = ^{
                            printf("big number: %d\n", i);
                        };
                        // WRONG: The block literal scope is the "then" clause.
                    }
                    else
                    {
                        block = ^{
                            printf("small number: %d\n", i);
                        };
                        // WRONG: The block literal scope is the "else" clause.
                    }
                    block();

                    printf("------- end of not do's\n\n\n");
                };
                [self.navigationController pushViewController:testVC animated:YES];
                [testVC release];
                break;
                
            case 1:
                testVC = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
                testVC.doThis = ^{
                    printf("------- start test %ld do's\n", (long)indexPath.row+1);     // if we don't use local variable as in this line, block will be NSGlobalBlock
                    __block int counter = 0;
                    for (int i=0; i<5; i++)
                    {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            counter++;
                            printf("counter: %d\n", counter);
                        });
                    }
//                    sleep(2);
                    printf("outter counter: %d\n", counter);
                    printf("------- end of do's\n\n\n");
                };
                testVC.doNotDoThis = ^ {
                    printf("------- start test %ld not do's\n", (long)indexPath.row+1);     // if we don't use local variable as in this line, block will be NSGlobalBlock
                    int counter = 0;
                    for (int i=0; i<5; i++)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // well... it just won't compile
//                            counter++;
                            printf("counter: %d\n", counter);
                        });
                    }
                    sleep(2);
                    printf("outter counter: %d\n", counter);
                    printf("------- end of not do's\n\n\n");
                };
                [self.navigationController pushViewController:testVC animated:YES];
                [testVC release];
                break;
                
            case 2:
                testVC = [[TestViewController alloc] init];
#warning why following line is not working?!
                testVC.testInfoLabel.text = @"Use __block to break retain cycle.";
                bTestVC = testVC;
                testVC.doThis = ^{
                    printf("------- start test %ld do's\n", (long)indexPath.row+1);     // if we don't use local variable as in this line, block will be NSGlobalBlock
                    NSLog(@"%@", bTestVC);
                    [bTestVC.navigationController popViewControllerAnimated:YES];
                    printf("------- end of do's\n\n\n");
                };
                testVC.doNotDoThis = ^ {
                    printf("------- start test %ld not do's\n", (long)indexPath.row+1);     // if we don't use local variable as in this line, block will be NSGlobalBlock
#warning with the following line there's a retain cycle, even for "do this" button, you know why
//                    NSLog(@"%@", testVC);
                    [bTestVC.navigationController popViewControllerAnimated:YES];
                    printf("------- end of not do's\n\n\n");
                };
                [self.navigationController pushViewController:testVC animated:YES];
                [testVC release];
                break;
                
            case 3:
                testVC = [[TestViewController alloc] init];
                bTestVC = testVC;
                bIVarStr = _iVarStr;
                _iVarStr = @"hello 1";
                testVC.doThis = ^{
#warning swap iVarStr/bIVarStr and try, breakpoint in this block, po self, po _iVarStr (note we cannot NSLog self in the block, otherwise thing changed). Actually even po sees nothing, invalid test?
                    printf("------- start test %ld do's\n", (long)indexPath.row+1);     // if we don't use local variable as in this line, block will be NSGlobalBlock
                    NSLog(@"%@. retain count: %lu", _iVarStr, (unsigned long)[_iVarStr retainCount]);
//                    NSLog(@"%@. retain count: %lu", bIVarStr, (unsigned long)[bIVarStr retainCount]);
                    [bTestVC.navigationController popViewControllerAnimated:YES];
                    printf("------- end of do's\n\n\n");
                };
                _iVarStr = @"hello 2";
                testVC.doNotDoThis = ^ {
                    printf("------- start test %ld not do's\n", (long)indexPath.row+1);     // if we don't use local variable as in this line, block will be NSGlobalBlock
                    NSLog(@"%@. retain count: %lu", _iVarStr, (unsigned long)[_iVarStr retainCount]);
//                    NSLog(@"%@. retain count: %lu", bIVarStr, (unsigned long)[bIVarStr retainCount]);
                    [bTestVC.navigationController popViewControllerAnimated:YES];
                    printf("------- end of not do's\n\n\n");
                };
                [self.navigationController pushViewController:testVC animated:YES];
                [testVC release];
                break;
            
            case 4:
                testVC = [[TestViewController alloc] init];
                testVC.doThis = ^{
                    NSError *error = nil;
                    [[NSFileManager defaultManager] attributesOfItemAtPath:@"/Users/matthew/Desktop/mitsuihisashi.jpg" error:&error];
                    double delayInSeconds = 2.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        NSLog(@"%@", error);
                    });
                };
                testVC.doNotDoThis = ^ {
                    NSError *error;
                    [[NSFileManager defaultManager] attributesOfItemAtPath:@"/Users/matthew/Desktop/mitsuihisashi.jpg" error:&error];
                    double delayInSeconds = 2.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        NSLog(@"%@", error);
                    });
                };
                [self.navigationController pushViewController:testVC animated:YES];
                [testVC release];
                break;
                
            default:
                break;
        }
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
