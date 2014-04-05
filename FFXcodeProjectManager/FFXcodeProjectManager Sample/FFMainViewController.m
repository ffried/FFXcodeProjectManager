//
//  FFMainViewController.m
//  FFXcodeProjectManager Sample
//
//  Created by Florian Friedrich on 21.03.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFMainViewController.h"
#import <FFXcodeProjectManager/FFXcodeProjectManager.h>


@implementation FFMainViewController

- (void)selectFile:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowsMultipleSelection = NO;
    openPanel.allowedFileTypes = @[@"xcodeproj", @"pbxproj"];
    openPanel.message = @"Please select the project file which you want to evaluate.";
    
    NSInteger result = [openPanel runModal];
    if (result == NSFileHandlingPanelOKButton) {
        NSURL *selectedURL = openPanel.URLs.firstObject;
        if ([[selectedURL.lastPathComponent componentsSeparatedByString:@"."].lastObject
             isEqualToString:@"xcodeproj"]) {
            selectedURL = [selectedURL URLByAppendingPathComponent:@"project.pbxproj"];
        }
        self.selectedPathLabel.stringValue = selectedURL.path;
        FFXCProjectFile *projectFile = [[FFXCProjectFile alloc] initWithProjectFileURL:selectedURL];
        [self evaluateProjectFile:projectFile];
    }
}

- (void)evaluateProjectFile:(FFXCProjectFile *)projectFile
{
    NSArray *objects = projectFile.objects;
    NSMutableDictionary *typesDict = [NSMutableDictionary dictionary];
    NSString *header = [NSString stringWithFormat:@"### PROJECT FILE FOR %@ PROJECT ###",
                        projectFile.projectFileURL.path];
    NSMutableString *summary = [NSMutableString stringWithFormat:@"%ld objects\n", (long)objects.count];
    NSMutableString *detail = [NSMutableString string];
    [objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        NSNumber *nr = typesDict[obj.isa];
        if (!nr) nr = @0;
        typesDict[obj.isa] = @(nr.integerValue + 1);
        [detail appendFormat:@"%@: %@\n", obj.uid, obj.isa];
    }];
    [typesDict enumerateKeysAndObjectsUsingBlock:^(NSString *objIsa, NSNumber *count, BOOL *stop) {
        [summary appendFormat:@"%@: %@\n", objIsa, count.stringValue];
    }];
    self.outputTextField.stringValue = [NSString stringWithFormat:@"%@\n\n%@\n\n%@", header, summary, detail];
}

@end
