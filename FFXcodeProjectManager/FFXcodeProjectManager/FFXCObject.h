//
//  FFXCObject.h
//
//  Created by Florian Friedrich on 5.1.14.
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
#import <FFXcodeProjectManager/FFXCProjectUIDGenerator.h>

/**
 The name of the notification sent when an object was removed from a project file.
 @see FFXCDeletedObjectUserInfoKey
 */
extern NSString *FFXCObjectDeletedNotification;
/**
 The name of the notiication sent when an object was replaced in a project file.
 @see FFXCDeletedObjectUserInfoKey
 @see FFXCInsertedObjectUserInfoKey
 */
extern NSString *FFXCObjectReplacedNotification;
/**
 The key of the deleted object in the user info.
 @see FFXCObjectDeletedNotification
 @see FFXCObjectReplacedNotification
 */
extern NSString *FFXCDeletedObjectUserInfoKey;
/**
 The key of the inserted object in the user info.
 @see FFXCObjectReplacedNotification
 */
extern NSString *FFXCInsertedObjectUserInfoKey;

/**
 Represents a general object. Superclass of all objects in a project file.
 This is an abstract class, do not use this class directly. Instead use subclasses of this class.
 @see FFXCBuildPhase
 @see FFXCConfigurableObject
 @see FFXCBuildConfiguration
 @see FFXCConfigurationList
 @see FFXCFileObject
 @see FFXCGroup
 @see FFXCBuildFile
 @see FFXCContainerItemProxy
 @see FFXCTargetDependency
 @author Florian Friedrich
 */
@interface FFXCObject : NSObject <NSSecureCoding, NSCopying>

/**
 The UID identifying an object in a project file.
 */
@property (nonatomic, strong, readonly) NSString *uid;
/**
 The isa represents the type of an object.
 */
@property (nonatomic, strong) NSString *isa;


/**
 Creates a new object and generates a UID.
 @returns A new instance with a generated UID.
 */
- (instancetype)init;

/**
 Creates a new object with a given UID and a dictionary.
 Typically called when loading an object from a project file.
 @param uid The UID of the object. If nil a new UID will be generated.
 @param dictionary The dictionary containing the values of the object.
 @returns A new instance representing an object.
 */
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary;

/**
 Returns the object in its dictionary representation.
 Basically used for putting the object back into the project file.
 */
- (NSDictionary *)dictionaryRepresentation;

@end
