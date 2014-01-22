//
//  FFXCProjectFile.m
//
//  Created by Florian Friedrich on 12.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCProjectFile.h"

static NSString *const kArchiveVersionKey = @"archiveVersion";
static NSString *const kClassesKey = @"classes";
static NSString *const kObjectVersionKey = @"objectVersion";
static NSString *const kObjectsKey = @"objects";
static NSString *const kRootObjectKey = @"rootObject";

@interface FFXCProjectFile ()
// TODO: Only needed as long as not all objects have a representing class
@property (nonatomic, strong) NSDictionary *objectsDict;
@end

@implementation FFXCProjectFile

- (instancetype)initWithProjectFileURL:(NSURL *)projectFileURL
{
    self = [super init];
    if (self) {
        if (projectFileURL) {
            self.projectFileURL = projectFileURL;
            NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:projectFileURL];
            if (dictionary) {
                self.archiveVersion = dictionary[kArchiveVersionKey];
                self.classes = dictionary[kClassesKey];
                self.objectVersion = dictionary[kObjectVersionKey];
                
                NSDictionary *objects = dictionary[kObjectsKey];
                self.objectsDict = objects; // TODO: Remove once every object has a representing class
                
            }
        }
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSArray *keys = @[kArchiveVersionKey, kClassesKey, kObjectVersionKey];
    NSMutableDictionary *dictionary = [self dictionaryWithValuesForKeys:keys].mutableCopy;
    dictionary[kRootObjectKey] = self.rootObject.uid;
    
    // TODO: Create a new dictionary here once every object has a representing class
    NSMutableDictionary *objects = self.objectsDict.mutableCopy;
    [self.objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        objects[obj.uid] = [obj dictionaryRepresentation];
    }];
    dictionary[kObjectsKey] = objects.copy;
    
    return dictionary.copy;
}

@end
