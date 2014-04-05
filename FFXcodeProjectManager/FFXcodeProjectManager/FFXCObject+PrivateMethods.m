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
    return [array arrayByAddingObject:object];
}

- (NSArray *)replaceObject:(id)oldObject withObject:(id)newObject inArray:(NSArray *)array
{
    NSUInteger index = [array indexOfObject:oldObject];
    if (index != NSNotFound) {
        NSMutableArray *mutableArray = [array mutableCopy];
        [mutableArray replaceObjectAtIndex:index withObject:newObject];
        return [mutableArray copy];
    }
    return array;
}

- (NSArray *)removeObject:(id)object fromArray:(NSArray *)array
{
    NSUInteger index = [array indexOfObject:object];
    if (index != NSNotFound) {
        NSMutableArray *mutableArray = [array mutableCopy];
        [mutableArray removeObjectAtIndex:index];
        return [mutableArray copy];
    }
    return array;
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
