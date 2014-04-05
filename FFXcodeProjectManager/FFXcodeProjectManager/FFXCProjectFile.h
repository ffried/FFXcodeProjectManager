//
//  FFXCProjectFile.h
//
//  Created by Florian Friedrich on 12.1.14.
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

#import <Foundation/Foundation.h>

@class FFXCObject, FFXCObjectsManager;

/**
 Represents a project file (pbxproj).
 Conforms to NSSecureCoding.
 @author Florian Friedrich
 */
@interface FFXCProjectFile : NSObject <NSSecureCoding>

/**
 The URL of the project file.
 */
@property (nonatomic, strong) NSURL *projectFileURL;

/**
 The archiveVersion of the project file.
 */
@property (nonatomic, strong) NSNumber *archiveVersion;
/**
 The classes of the project file.
 */
@property (nonatomic, strong) NSArray *classes;
/**
 The objectVersion of the project file.
 */
@property (nonatomic, strong) NSNumber *objectVersion;
/**
 The objects of the project file.
 @see FFXCProjectFile#addObject:
 @see FFXCProjectFile#removeObject:
 @see FFXCProjectFile#replaceObject:withObject:
 @see FFXCProjectFile#objectWithUID:
 @see FFXCProjectFile#objectsOfType:
 */
@property (nonatomic, strong) NSArray *objects;

/**
 The rootObjectUID of the project file.
 */
@property (nonatomic, strong) NSString *rootObjectUID;

/**
 The objects manager responsible for saving objects added to this project file.
 Defaults to the sharedManager instance.
 @see FFXCObjectsManager
 */
@property (nonatomic, strong) FFXCObjectsManager *objectsManager;

/**
 Creates a new project file from a given URL.
 @param projectFileURL The URL of the project file (the .pbxproj file).
 @returns A new FFXCProject file instance.
 */
- (instancetype)initWithProjectFileURL:(NSURL *)projectFileURL;

/**
 Creates a dictionary with all objects and attributes.
 @returns The project file in its dictionary representation.
 */
- (NSDictionary *)dictionaryRepresentation;

/**
 Adds an object to the project file's objects.
 @param object The object to add.
 @see FFXCProjectFile#objects
 */
- (void)addObject:(FFXCObject *)object;
/**
 Removes an object from the project file's objects.
 @param object The object to remove.
 @see FFXCProjectFile#objects
 */
- (void)removeObject:(FFXCObject *)object;
/**
 Replaces an object with another object.
 @param oldObject The old object which will be replaced with newObject.
 @param newObject The object with which to replace the oldObject.
 @see FFXCProjectFile#objects
 */
- (void)replaceObject:(FFXCObject *)oldObject withObject:(FFXCObject *)newObject;

/**
 Searches for an object with a given UID.
 @param uid The UID of the object to search for.
 @returns A FFXCObject or nil if no object was found.
 @see FFXCProjectFile#objects
 */
- (FFXCObject *)objectWithUID:(NSString *)uid;
/**
 Searches for objects of a given type.
 @param type The type for which to search objects.
 @returns An array of objects found for the type (can be empty if no objects were found).
 @see FFXCProjectFile#objects
 */
- (NSArray *)objectsOfType:(NSString *)type;

@end
