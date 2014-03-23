//
//  FFXCObjectsManager.h
//
//  Created by Florian Friedrich on 16.2.14.
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

@class FFXCObject;

/**
 Manages objects which are added or removed to/from a project file.
 This class should be used to directly add 
 */
@interface FFXCObjectsManager : NSObject

/**
 Sets the objects manager enabled/disabled.
 The objects manager only saves objects if enabled is set to YES.
 */
@property (nonatomic, assign) BOOL enabled;

/**
 The shared manager.
 @returns The shared manager instance.
 */
+ (instancetype)sharedManager;

/**
 Saves an object.
 @param object The object to save.
 @param projectFilePath The url of the project file for which to save the object.
 */
- (void)saveObject:(FFXCObject *)object forProjectFilePath:(NSURL *)projectFilePath;
/**
 Deletes a saves object.
 @param object The object to delete.
 @param projectFilePath The url of the project file for which to delete the object.
 */
- (void)deleteObject:(FFXCObject *)object ofProjectFilePath:(NSURL *)projectFilePath;

/**
 Returns all saved project file urls.
 @returns An array of all saved project file paths. This array can be empty.
 */
- (NSArray *)savedProjectFilesPaths;
/**
 Returns all saved objects for a project file url.
 @param projectFilePath The url of the project file for which to return the saved objects.
 @returns An array of all saved objects for the project file at the given url.
 */
- (NSArray *)savedObjectsForProjectFilePath:(NSURL *)projectFilePath;

/**
 Writes the saved objects to the file at the given url.
 @param path The path to which to save the saved objects.
 @param error Will be set to any error which might occur while saving.
 @returns YES or NO wheter or not the write operation was successful.
 @see FFXCObjectsManager#loadFromPath:error:
 */
- (BOOL)writeToPath:(NSURL *)path error:(NSError *__autoreleasing *)error;

/**
 Loads the saved objects from the file at the given url.
 @param path The path from which to load the saved objects.
 @param error Will be set to any error which might occur while loading.
 @returns YES or NO wheter or not the load operation was successful.
 @see FFXCObjectsManager#writeToPath:error:
 */
- (BOOL)loadFromPath:(NSURL *)path error:(NSError *__autoreleasing *)error;

@end
