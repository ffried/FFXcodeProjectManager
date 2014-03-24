//
//  FFXCProject.h
//
//  Created by Florian Friedrich on 20.1.14.
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
 The isa of a project.
 @see FFXCProject
 @see FFXCObject#isa
 */
extern NSString *const kPBXProject;

/**
 Represents a project.
 @author Florian Friedrich
 */
@interface FFXCProject : FFXCConfigurableObject

/**
 The attributes of the project.
 Contains keys like "CLASSPREFIX", "ORGANIZATIONNAME", "TargetAttributes" (which is a dictionary as well), etc.
 */
@property (nonatomic, strong) NSDictionary *attributes;
/**
 The compatibility version of the project.
 */
@property (nonatomic, strong) NSString *compatibilityVersion;
/**
 The development region of the project.
 */
@property (nonatomic, strong) NSString *developmentRegion;
/**
 Whether or not it has scanned for encodings.
 */
@property (nonatomic, assign) BOOL hasScannedForEncodings;
/**
 The known regions of the project.
 Contains strings like "Base", "en", "de" and so on.
 @see FFXCProject#addKnownRegion:
 @see FFXCProject#removeKnownRegion:
 */
@property (nonatomic, strong) NSArray *knownRegions;
/**
 The UID of the main group of the project.
 */
@property (nonatomic, strong) NSString *mainGroupUID;
/**
 The UID of the reference group of the project.
 */
@property (nonatomic, strong) NSString *projectRefGroupUID;
/**
 The path to the project directory.
 */
@property (nonatomic, strong) NSString *projectDirPath;
/**
 The root of the project.
 */
@property (nonatomic, strong) NSString *projectRoot;
/**
 The UIDs of the targets of the project.
 @see FFXCProject#addTargetUID:
 @see FFXCProject#removeTargetUID:
 */
@property (nonatomic, strong) NSArray *targetUIDs;

/**
 Adds a known region to the project.
 @param knownRegion The known region to add.
 @see FFXCProject#knownRegions
 */
- (void)addKnownRegion:(NSString *)knownRegion;
/**
 Removes a known region from the project.
 @param knownRegion The known region to remove.
 @see FFXCProject#knownRegions
 */
- (void)removeKnownRegion:(NSString *)knownRegion;

/**
 Adds a target UID to the project.
 @param targetUID The UID of the target to add.
 @see FFXCProject#targetUIDs
 */
- (void)addTargetUID:(NSString *)targetUID;
/**
 Removes a target UID from the project.
 @param targetUID The UID of the target to remove.
 @see FFXCProject#targetUIDs
 */
- (void)removeTargetUID:(NSString *)targetUID;

@end
