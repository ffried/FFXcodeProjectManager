//
//  FFXCProjectFile.m
//
//  Created by Florian Friedrich on 12.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCProjectFile.h"
#import <FFXcodeProjectManager/FFXCObject+ClassFactory.h>
#import <FFXcodeProjectManager/FFXCObjectsManager.h>

static NSString *const kArchiveVersionKey = @"archiveVersion";
static NSString *const kClassesKey = @"classes";
static NSString *const kObjectVersionKey = @"objectVersion";
static NSString *const kObjectsKey = @"objects";
static NSString *const kRootObjectUIDKey = @"rootObject";

static NSString *const kProjectFileURLKey = @"projectFileURL";
static NSString *const kUnknownObjectsKey = @"unknownObjects";

@interface FFXCProjectFile ()

@property (nonatomic, strong) NSDictionary *unknownObjects;

@end


@implementation FFXCProjectFile

#pragma mark - Initializer
- (instancetype)initWithProjectFileURL:(NSURL *)projectFileURL
{
    self = [super init];
    if (self) {
        if (projectFileURL != nil) {
            self.projectFileURL = projectFileURL;
            NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:projectFileURL];
            if (dictionary) {
                self.archiveVersion = (dictionary[kArchiveVersionKey]) ?: @"";
                self.classes = dictionary[kClassesKey];
                self.objectVersion = dictionary[kObjectVersionKey];
                
                NSMutableDictionary *unknownObjects = [[NSMutableDictionary alloc] init];
                NSMutableArray *objects = [[NSMutableArray alloc] init];
                [dictionary[kObjectsKey] enumerateKeysAndObjectsUsingBlock:^(NSString *uid, NSDictionary *objDict, BOOL *stop) {
                    Class objClass = [FFXCObject classForDictionary:objDict];
                    if (objClass) {
                        [objects addObject:[[objClass alloc] initWithUID:uid ofDictionary:objDict]];
                    } else {
                        NSLog(@"Found unknown object: %@", objDict);
                        unknownObjects[uid] = objDict;
                    }
                }];
                self.objects = objects.copy;
                
            }
        }
        self.objectsManager = [FFXCObjectsManager sharedManager];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithProjectFileURL:nil];
}

#pragma mark - Add and Remove Methods
- (void)addObject:(FFXCObject *)object
{
    self.objects = [self.objects arrayByAddingObject:object];
    [self.objectsManager saveObject:object forProjectFilePath:self.projectFileURL];
}

- (void)removeObject:(FFXCObject *)object
{
    NSInteger index = [self.objects indexOfObject:object];
    if (index != NSNotFound) {
        NSMutableArray *objs = self.objects.mutableCopy;
        [objs removeObjectAtIndex:index];
        self.objects = objs.copy;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:FFXCObjectDeletedNotification object:self userInfo:@{FFXCDeletedObjectUserInfoKey: object}];
    [self.objectsManager deleteObject:object ofProjectFilePath:self.projectFileURL];
}

- (void)replaceObject:(FFXCObject *)oldObject withObject:(FFXCObject *)newObject
{
    NSInteger index = [self.objects indexOfObject:oldObject];
    if (index != NSNotFound) {
        NSMutableArray *objs = self.objects.mutableCopy;
        [objs replaceObjectAtIndex:index withObject:newObject];
        self.objects = objs.copy;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:FFXCObjectReplacedNotification object:self userInfo:@{FFXCDeletedObjectUserInfoKey: oldObject, FFXCInsertedObjectUserInfoKey: newObject}];
    [self.objectsManager deleteObject:oldObject ofProjectFilePath:self.projectFileURL];
    [self.objectsManager saveObject:newObject forProjectFilePath:self.projectFileURL];
}

#pragma mark - Get Objects
- (FFXCObject *)objectWithUID:(NSString *)uid
{
    __block FFXCObject *object = nil;
    [self.objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.uid isEqualToString:uid]) {
            object = obj;
            *stop = YES;
        }
    }];
    return object;
}

- (NSArray *)objectsOfType:(NSString *)type
{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    [self.objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.isa isEqualToString:type]) {
           [objects addObject:obj];
        }
    }];
    return objects.copy;
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding { return YES; }

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        self.archiveVersion = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kArchiveVersionKey];
        self.classes = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kClassesKey];
        self.objectVersion = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kObjectVersionKey];
        self.objects = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kObjectsKey];
        self.rootObjectUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kRootObjectUIDKey];
        
        self.projectFileURL = [aDecoder decodeObjectOfClass:[NSURL class] forKey:kProjectFileURLKey];
        self.unknownObjects = [aDecoder decodeObjectOfClass:[NSDictionary class] forKey:kUnknownObjectsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.archiveVersion forKey:kArchiveVersionKey];
    [aCoder encodeObject:self.classes forKey:kClassesKey];
    [aCoder encodeObject:self.objectVersion forKey:kObjectVersionKey];
    [aCoder encodeObject:self.objects forKey:kObjectsKey];
    [aCoder encodeObject:self.rootObjectUID forKey:kRootObjectUIDKey];
    
    [aCoder encodeObject:self.projectFileURL forKey:kProjectFileURLKey];
    [aCoder encodeObject:self.unknownObjects forKey:kUnknownObjectsKey];
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSArray *keys = @[kArchiveVersionKey,
                      kClassesKey,
                      kObjectVersionKey,
                      kRootObjectUIDKey];
    
    NSMutableDictionary *dictionary = [self dictionaryWithValuesForKeys:keys].mutableCopy;
    
    NSMutableDictionary *objects = self.unknownObjects.mutableCopy;
    [self.objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        objects[obj.uid] = [obj dictionaryRepresentation];
    }];
    dictionary[kObjectsKey] = objects.copy;
    
    return dictionary.copy;
}

@end
