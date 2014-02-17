//
//  FFXCObject+PrivateMethods.m
//
//  Created by Florian Friedrich on 17.2.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject+PrivateMethods.h"

@implementation FFXCObject (PrivateMethods)

#pragma mark - Collection add and remove methods
- (NSArray *)addObject:(id)object toArray:(NSArray *)array
{
    return nil;
}

- (NSArray *)replaceObject:(id)oldObject withObject:(id)newObject inArray:(NSArray *)array
{
    return nil;
}

- (NSArray *)removeObject:(id)object fromArray:(NSArray *)array
{
    return nil;
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    // We have nothing to do here...
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    // We have nothing to do here...
}

@end
