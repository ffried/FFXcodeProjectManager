//
//  FFXCTarget.h
//
//  Created by Florian Friedrich on 21.1.14.
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

#import <FFXcodeProjectManager/FFXCConfigurableObject.h>

/**
 Represents a target.
 This is an abstract class, do not use this class directly. Instead use subclasses of this class.
 @see FFXCAggregateTarget
 @see FFXCNativeTarget
 @author Florian Friedrich
 */
@interface FFXCTarget : FFXCConfigurableObject

/**
 The UIDs of the build phases.
 @see FFXCTarget#addBuildPhaseUID:
 @see FFXCTarget#removeBuildPhaseUID:
 */
@property (nonatomic, strong) NSArray *buildPhaseUIDs;
/**
 The UIDs of the dependencies.
 @see FFXCTarget#addDependencyUID:
 @see FFXCTarget#removeDependencyUID:
 */
@property (nonatomic, strong) NSArray *dependencyUIDs;
/**
 The name of the target.
 */
@property (nonatomic, strong) NSString *name;
/**
 The product's name of the target.
 */
@property (nonatomic, strong) NSString *productName;

/**
 Adds a build phase UID.
 @param buildPhaseUID The UID of the build phase to add.
 @see FFXCTarget#buildPhaseUIDs
 */
- (void)addBuildPhaseUID:(NSString *)buildPhaseUID;
/**
 Removes a build phase UID.
 @param buildPhaseUID The UID of the build phase to remove.
 @see FFXCTarget#buildPhaseUIDs
 */
- (void)removeBuildPhaseUID:(NSString *)buildPhaseUID;

/**
 Adds a dependency UID.
 @param dependencyUID The UID of the dependency to add.
 @see FFXCTarget#dependecyUIDs
 */
- (void)addDependencyUID:(NSString *)dependencyUID;
/**
 Removes a dependency UID.
 @param dependencyUID The UID of the dependency to remove.
 @see FFXCTarget#dependencyUIDs
 */
- (void)removeDependencyUID:(NSString *)dependencyUID;

@end
