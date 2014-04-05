//
//  FFAppDelegate.h
//  FFXcodeProjectManager Sample
//
//  Created by Florian Friedrich on 11.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FFMainViewController.h"

@interface FFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) FFMainViewController *mainViewController;

@end
