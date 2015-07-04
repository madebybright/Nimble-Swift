//
//  AppDelegate.m
//  Bright
//
//  Created by Josh Trommel on 2015-04-10.
//  Copyright (c) 2015 Intui, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize window  = _window;
@synthesize popover = _popover;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@""];
    [statusItem setImage:[NSImage imageNamed:@"statusIcon"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"altStatusIcon"]];
    [statusItem setHighlightMode:YES];
    
    [statusItem setTarget:self];
    [statusItem setAction:@selector(showPopover:)];
}

- (IBAction)showPopover:(id)sender {
    [_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxXEdge];
}

- (IBAction)tempMakeQuery:(id)sender {
    NSString *input = [_input stringValue];
    NSString *escapedInput = [input stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *params = @{@"i": escapedInput};
    
    /* Make request and return response */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://bright-backend.herokuapp.com/input" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"result"][@"success"]  isEqual: @1]) {
            /* Input returned success */
            NSString *implyingString = [NSString stringWithFormat:@"implying you meant %@", responseObject[@"result"][@"input"]];
            _implying.stringValue = implyingString;
            _output.stringValue = responseObject[@"result"][@"result"][@"plaintext"];
        } else {
            /* Input returned failure */
            _output.stringValue = @"Check your input, it doesn't seem valid.";
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _output.stringValue = [NSString stringWithFormat:@"Uh oh! There was problem with %@", input];
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)quit:(id)sender {
    [NSApp terminate: self];
}

@end