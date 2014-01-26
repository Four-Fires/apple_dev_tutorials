//
//  ChatClientViewController.m
//  ChatClient
//
//  Created by matthew on 2014-01-25.
//  Copyright (c) 2014 matthew. All rights reserved.
//

#import "ChatClientViewController.h"

@interface ChatClientViewController ()
{
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    BOOL _loggedIn;
    NSString *_loginName;
    BOOL _canSend;
    NSMutableArray *_commandList;
}

@end

@implementation ChatClientViewController

- (void)_connectSocket
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 80, &readStream, &writeStream);
    _inputStream = (NSInputStream*)readStream;
    _outputStream = (NSOutputStream*)writeStream;
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    [_outputStream open];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _commandList = [[NSMutableArray alloc] init];
        
        [self _connectSocket];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _joinChat.enabled = NO;
    _loggedIn = NO;
    _inputNameField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    if (_inputStream)
    {
        [_inputStream close];
        [_inputStream release];
    }
    if (_outputStream)
    {
        [_outputStream close];
        [_outputStream release];
    }
    
    [_commandList release];
    
    [_inputNameField release];
    [_joinView release];
    [_joinChat release];
    [_messageList release];
    [_messageToSend release];
    [super dealloc];
}

- (IBAction)onJoin:(id)sender
{
    NSString *joinCmd = [NSString stringWithFormat:@"iam:%@", _inputNameField.text];
    [_commandList addObject:joinCmd];
    
    [_joinView setHidden:YES];
    _loggedIn = YES;
    
    if (_canSend)
    {
        if ([self _sendCommand:[_commandList objectAtIndex:0]])
            [_commandList removeObjectAtIndex:0];
        _canSend = NO;
    }
    
    [_inputNameField resignFirstResponder];
}

- (IBAction)onSend:(id)sender
{
    if (_messageToSend.text && ![_messageToSend.text isEqualToString:@""])
    {
        NSString *msgCmd = [NSString stringWithFormat:@"msg:%@", _messageToSend.text];
        [_commandList addObject:msgCmd];
        
        if (_canSend)
        {
            if ([self _sendCommand:[_commandList objectAtIndex:0]])
                [_commandList removeObjectAtIndex:0];
            _canSend = NO;
        }
        
        _messageToSend.text = @"";
    }
}

- (IBAction)onConnectServer:(id)sender
{
    [self _connectSocket];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_outputStream && string!=nil && ![string isEqualToString:@""])
    {
        _joinChat.enabled = YES;
    }
    else
    {
        _joinChat.enabled = NO;
    }
    return YES;
}

- (void)_handleStreamError
{
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream release];
    _outputStream = nil;
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream release];
    _inputStream = nil;
    _canSend = NO;
    _loggedIn = NO;
    
    _messageList.text = @"";
    [_joinView setHidden:NO];
    
    [_commandList removeAllObjects];
}

- (BOOL)_sendCommand:(NSString*)command
{
    NSLog(@"%s", __func__);
    NSLog(@"sending command: %@", command);
    
    BOOL ret = NO;
    NSData *data = [command dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t *bytes = (uint8_t *)[data bytes];
    int len = [data length];
    if (-1 == [_outputStream write:bytes maxLength:len])
    {
        [self _handleStreamError];
    }
    else
    {
        ret = YES;
    }
    return ret;
}

#pragma mark - NSStreamDelegate methods

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    NSLog(@"%s", __func__);
    
    uint8_t buf[1024];
    int read_len;
    NSString *read_str;
    
    switch (eventCode) {
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"NSStreamEventHasSpaceAvailable");
            if ([_commandList count]>0)
            {
                if ([self _sendCommand:[_commandList objectAtIndex:0]])
                    [_commandList removeObjectAtIndex:0];
                _canSend = NO;
            }
            else
                _canSend = YES;
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"NSStreamEventHasBytesAvailable");
            read_len = [_inputStream read:buf maxLength:1024];
            if (read_len>0)
            {
                read_str = [[NSString alloc] initWithData:[NSData dataWithBytes:buf length:read_len] encoding:NSUTF8StringEncoding];
                NSLog(@"available bytes are: %@", read_str);
                _messageList.text = [_messageList.text stringByAppendingString:read_str];
                [read_str release];
            }
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"NSStreamEventErrorOccurred");
            [self _handleStreamError];
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"NSStreamEventEndEncountered");
            [self _handleStreamError];
            break;
        default:
            break;
    }
}


@end
