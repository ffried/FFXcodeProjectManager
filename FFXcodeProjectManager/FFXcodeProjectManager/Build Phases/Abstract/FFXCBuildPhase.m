//
//  FFXCBuildPhase.m
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCBuildPhase.h"
#import "FFXCObject+PrivateMethods.h"

NSUInteger const kDefaultBuildActionMask = 2147483647;

static NSString *const kBuildActionMaskKey = @"buildActionMask";
static NSString *const kFileUIDsKey = @"files";
static NSString *const kRunOnlyForDeploymentPostprocessingKey = @"runOnlyForDeploymentPostprocessing";


@implementation FFXCBuildPhase

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildActionMask = (dictionary[kBuildActionMaskKey]) ?: @(kDefaultBuildActionMask);
        self.fileUIDs = dictionary[kFileUIDsKey] ?: @[];
        self.runOnlyForDeploymentPostprocessing = [dictionary[kRunOnlyForDeploymentPostprocessingKey] boolValue];
    }
    return self;
}

#pragma mark - Add and Remove Methods
- (void)addFileUID:(NSString *)fileUID
{
    self.fileUIDs = [self addObject:fileUID toArray:self.fileUIDs];
}

- (void)removeFileUID:(NSString *)fileUID
{
    self.fileUIDs = [self removeObject:fileUID fromArray:self.fileUIDs];
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) [self removeFileUID:deletedObj.uid];
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        self.fileUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.fileUIDs];
    } else if (deletedObj) {
        [self handleObjectDeletedNotification:note];
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildActionMask = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kBuildActionMaskKey];
        self.fileUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kFileUIDsKey];
        self.runOnlyForDeploymentPostprocessing = [aDecoder decodeBoolForKey:kRunOnlyForDeploymentPostprocessingKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildActionMask forKey:kBuildActionMaskKey];
    [aCoder encodeObject:self.fileUIDs forKey:kFileUIDsKey];
    [aCoder encodeBool:self.runOnlyForDeploymentPostprocessing forKey:kRunOnlyForDeploymentPostprocessingKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildActionMask = [self.buildActionMask copyWithZone:zone];
    copy.fileUIDs = [self.fileUIDs copyWithZone:zone];
    copy.runOnlyForDeploymentPostprocessing = self.runOnlyForDeploymentPostprocessing;
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildActionMaskKey,
                      kFileUIDsKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kRunOnlyForDeploymentPostprocessingKey] = (self.runOnlyForDeploymentPostprocessing) ? @(1) : @(0);
    
    return dict.copy;
}

@end
