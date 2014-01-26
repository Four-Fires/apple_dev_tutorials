//
//  ChatClientViewController.h
//  ChatClient
//
//  Created by matthew on 2014-01-25.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatClientViewController : UIViewController <NSStreamDelegate, UITextFieldDelegate>

- (IBAction)onJoin:(id)sender;
- (IBAction)onSend:(id)sender;
- (IBAction)onConnectServer:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *inputNameField;
@property (retain, nonatomic) IBOutlet UIView *joinView;
@property (retain, nonatomic) IBOutlet UIButton *joinChat;
@property (retain, nonatomic) IBOutlet UITextView *messageList;
@property (retain, nonatomic) IBOutlet UITextField *messageToSend;

@end
