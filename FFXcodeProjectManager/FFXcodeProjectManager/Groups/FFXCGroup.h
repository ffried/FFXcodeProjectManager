//
//  FFXCGroup.h
//
//  Created by Florian Friedrich on 19.1.14.
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
 The isa of a group.
 @see FFXCGroup
 @see FFXCObject#isa
 */
extern NSString *const kPBXGroup;

/**
 Represents a group.
 @author Florian Friedrich
 */
@interface FFXCGroup : FFXCObject

/**
 The UIDs of the group's children.
 @see FFXCGroup#addChildUID:
 @see FFXCGroup#removeChildUID:
 */
@property (nonatomic, strong) NSArray *childUIDs;
/**
 The source tree of the group.
 */
@property (nonatomic, strong) NSString *sourceTree;

/**
 The name of the group. Can be nil.
 */
@property (nonatomic, strong) NSString *name;
/**
 The path of the group. Can be nil.
 */
@property (nonatomic, strong) NSString *path;


/**
 Adds a UID of a child to the children.
 @param childUID The uid of the child to add.
 @see FFXCGroup#childUIDs
 */
- (void)addChildUID:(NSString *)childUID;
/**
 Removes a child UID for the children.
 @param childUID The UID of the child to remove.
 @see FFXCGroup#childUIDs
 */
- (void)removeChildUID:(NSString *)childUID;

@end
