//
//  FFMainViewController.m
//  FFXcodeProjectManager Sample
//
//  Created by Florian Friedrich on 21.03.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFMainViewController.h"
#import "FFXCObjects.h"
#import "FFXCProjectFile.h"

@interface FFMainViewController ()

@end

@implementation FFMainViewController

- (void)selectFile:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowsMultipleSelection = NO;
    openPanel.allowedFileTypes = @[@"xcodeproj", @"pbxproj"];
    
    NSInteger result = [openPanel runModal];
    if (result == NSFileHandlingPanelOKButton) {
        NSURL *selectedURL = openPanel.URLs.firstObject;
        self.selectedPathLabel.stringValue = selectedURL.absoluteString;
        FFXCProjectFile *projectFile = [[FFXCProjectFile alloc] initWithProjectFileURL:selectedURL];
        [self evaluateProjectFile:projectFile];
    }
}

- (void)evaluateProjectFile:(FFXCProjectFile *)projectFile
{
    NSMutableString *desc = [NSMutableString string];
    NSMutableDictionary *typesDict = [NSMutableDictionary dictionary];
    NSArray *objects = projectFile.objects;
    [desc appendFormat:@"### PROJECT FILE AT %@ ###\n", projectFile.projectFileURL.absoluteString];
    [desc appendFormat:@"%ld objects\n", (long)objects.count];
    [objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        NSNumber *nr = typesDict[obj.isa];
        if (!nr) nr = @0;
        typesDict[obj.isa] = @(nr.integerValue + 1);
        [desc appendFormat:@"%@: %@\n", obj.uid, obj.isa];
    }];
    [typesDict enumerateKeysAndObjectsUsingBlock:^(NSString *objIsa, NSNumber *count, BOOL *stop) {
        [desc appendFormat:@"%@: %@\n", objIsa, count.stringValue];
    }];
}

@end
