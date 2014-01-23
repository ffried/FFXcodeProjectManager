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
static NSString *const kRootObjectUIDKey = @"rootObject";

static NSString *const kProjectFileURLKey = @"projectFileURL";

@interface FFXCProjectFile ()

// TODO: Only needed as long as not all objects have a representing class
@property (nonatomic, strong) NSDictionary *objectsDict;

@end


@implementation FFXCProjectFile

#pragma mark - Initializer
- (instancetype)initWithProjectFileURL:(NSURL *)projectFileURL
{
    self = [super init];
    if (self) {
        if (projectFileURL) {
            self.projectFileURL = projectFileURL;
            NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:projectFileURL];
            if (dictionary) {
                self.archiveVersion = (dictionary[kArchiveVersionKey]) ?: @"";
                self.classes = dictionary[kClassesKey];
                self.objectVersion = dictionary[kObjectVersionKey];
                
                NSDictionary *objectsDict = dictionary[kObjectsKey];
                NSMutableArray *objects = [[NSMutableArray alloc] init];
                [objectsDict enumerateKeysAndObjectsUsingBlock:^(NSString *uid, NSDictionary *objDict, BOOL *stop) {
                    
                }];
                self.objectsDict = objectsDict; // TODO: Remove once every object has a representing class
                self.objects = objects.copy;
                
            }
        }
    }
    return self;
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding { return YES; }

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.projectFileURL = [aDecoder decodeObjectOfClass:[NSURL class] forKey:kProjectFileURLKey];
        self.archiveVersion = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kArchiveVersionKey];
        self.classes = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kClassesKey];
        self.objectVersion = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kObjectVersionKey];
        self.objects = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kObjectsKey];
        self.rootObjectUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kRootObjectUIDKey];
        
        self.objectsDict = [aDecoder decodeObjectOfClass:[NSDictionary class] forKey:@"objectsDict"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.projectFileURL forKey:kProjectFileURLKey];
    [aCoder encodeObject:self.archiveVersion forKey:kArchiveVersionKey];
    [aCoder encodeObject:self.classes forKey:kClassesKey];
    [aCoder encodeObject:self.objectVersion forKey:kObjectVersionKey];
    [aCoder encodeObject:self.objects forKey:kObjectsKey];
    [aCoder encodeObject:self.rootObjectUID forKey:kRootObjectUIDKey];
    
    [aCoder encodeObject:self.objectsDict forKey:@"objectsDict"];
}

/*#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [[[self class] alloc] init];
    
    // UID not copied as it's unique to one object!
    // It's generated in the init method
    copy.isa = [self.isa copyWithZone:zone];
    
    return copy;
}*/

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSArray *keys = @[kArchiveVersionKey,
                      kClassesKey,
                      kObjectVersionKey,
                      kRootObjectUIDKey];
    NSMutableDictionary *dictionary = [self dictionaryWithValuesForKeys:keys].mutableCopy;
    
    // TODO: Create a new dictionary here once every object has a representing class
    NSMutableDictionary *objects = self.objectsDict.mutableCopy;
    [self.objects enumerateObjectsUsingBlock:^(FFXCObject *obj, NSUInteger idx, BOOL *stop) {
        objects[obj.uid] = [obj dictionaryRepresentation];
    }];
    dictionary[kObjectsKey] = objects.copy;
    
    return dictionary.copy;
}

@end
