//
//  FFXCConfigurationList.h
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
 The isa of a configuration list.
 @see FFXCConfigurationList
 @see FFXCObject#isa
 */
extern NSString *const kXCConfigurationList;

/**
 Represents a configuration list.
 @author Florian Friedrich
 */
@interface FFXCConfigurationList : FFXCObject

/**
 The UIDs of the configurations.
 @see FFXCConfigurationList#addBuildConfigurationUID:
 @see FFXCConfigurationList#removeBuildConfigurationUID:
 */
@property (nonatomic, strong) NSArray *buildConfigurationUIDs;
/**
 Whether or not the default configuration is visible.
 */
@property (nonatomic, assign) BOOL defaultConfigurationIsVisible;
/**
 The name of the default configuration.
 */
@property (nonatomic, strong) NSString *defaultConfigurationName;

/**
 Adds a UID of a configuration.
 @param buildConfigurationUID The UID of the configuration to add.
 @see FFXCConfigurationList#buildConfigurationUIDs
 */
- (void)addBuildConfigurationUID:(NSString *)buildConfigurationUID;
/**
 Removes a UID of a configuration.
 @param buildConfigurationUID The UID of the configuration to remove.
 @see FFXCConfigurationList#buildConfigurationUIDs
 */
- (void)removeBuildConfigurationUID:(NSString *)buildConfigurationUID;

@end
