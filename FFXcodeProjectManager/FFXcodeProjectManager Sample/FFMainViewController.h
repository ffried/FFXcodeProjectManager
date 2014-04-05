//
//  FFMainViewController.h
//  FFXcodeProjectManager Sample
//
//  Created by Florian Friedrich on 21.03.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FFMainViewController : NSViewController

@property (nonatomic, weak) IBOutlet NSButton *selectFileButton;
@property (nonatomic, weak) IBOutlet NSTextField *selectedPathLabel;
@property (nonatomic, weak) IBOutlet NSTextField *outputTextField;

- (IBAction)selectFile:(id)sender;

@end
