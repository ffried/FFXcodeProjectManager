//
//  FFXCObject+PrivateMethods.h
//
//  Created by Florian Friedrich on 17.2.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <FFXcodeProjectManager/FFXCObject.h>

/**
 The PrivateMethods category on FFXCObject.
 Contains the private methods of FFXCObject.
 @author Florian Friedrich
 */
@interface FFXCObject (PrivateMethods)

/**
 Handles the object deleted notification.
 @param note The notification about a deleted object.
 @see FFXCObjectDeletedNotification
 */
- (void)handleObjectDeletedNotification:(NSNotification *)note;
/**
 Handles the object replaced notification.
 @param note The notification about a replaced object.
 @see FFXCObjectReplacedNotification
 */
- (void)handleObjectReplacedNotification:(NSNotification *)note;

/**
 Adds an object object to an array.
 @param object The object to add to the array.
 @param array The array to which to add the object.
 @returns An array with the object added to the given array.
 */
- (NSArray *)addObject:(id)object toArray:(NSArray *)array;
/**
 Replaces an object with another object in an array.
 @param oldObject The object to be replaced.
 @param newObject The object with which to replace the oldObject.
 @param array The array in which to replace the oldObject.
 @returns An array in which the oldObject was replaced with newObject.
 */
- (NSArray *)replaceObject:(id)oldObject withObject:(id)newObject inArray:(NSArray *)array;
/**
 Removes an object object from an array.
 @param object The object to delete from the array.
 @param array The array from which to delete the object.
 @returns An array without the removed object.
 */
- (NSArray *)removeObject:(id)object fromArray:(NSArray *)array;

@end
