//
//  FFXCBuildPhase.h
//
//  Created by Florian Friedrich on 18.1.14.
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
 The default build action mask.
 @see FFXCBuildPhase#buildActionMask
 */
extern NSUInteger const kDefaultBuildActionMask;

/**
 Represents a general build phase.
 This is an abstract class, do not use this class directly. Instead use subclasses of this class.
 @see FFXCFrameworksBuildPhase
 @see FFXCHeadersBuildPhase
 @see FFXCResourcesBuildPhase
 @see FFXCSourcesBuildPhase
 @author Florian Friedrich
 */
@interface FFXCBuildPhase : FFXCObject

/**
 The build action mask of the build phase.
 Mostly the default build action mask kDefaultBuildActionMask.
 @see kDefaultBuildActionMask
 */
@property (nonatomic, strong) NSNumber *buildActionMask;
/**
 The UIDs of the files included in the build phase.
 @see FFXCBuildPhase#addFileUID:
 @see FFXCBuildPhase#removeFileUID:
 */
@property (nonatomic, strong) NSArray *fileUIDs;
/**
 Whether or not the build phase only runs for deployment postprocessing, aka release builds.
 */
@property (nonatomic, assign) BOOL runOnlyForDeploymentPostprocessing;

/**
 Adds a file UID to the build phase.
 @param fileUID The UID of the file to add.
 @see FFXCBuildPhase#fileUIDs
 */
- (void)addFileUID:(NSString *)fileUID;
/**
 Removes a file UID from the build phase.
 @param fileUID The UID of the file to remove.
 @see FFXCBuildPhase#fileUIDs
 */
- (void)removeFileUID:(NSString *)fileUID;

@end
