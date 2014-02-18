//
//  FFXCProject.m
//
//  Created by Florian Friedrich on 20.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCProject.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXProject = @"PBXProject";

static NSString *const kAttributesKey = @"attributes";
static NSString *const kCompatibilityVersionKey = @"compatibilityVersion";
static NSString *const kDevelopmentRegionKey = @"developmentRegion";
static NSString *const kHasScannedForEncodingsKey = @"hasScannedForEncodings";
static NSString *const kKnownRegionsKey = @"knownRegions";
static NSString *const kMainGroupUIDKey = @"mainGroup";
static NSString *const kProjectRefGroupUIDKey = @"projectRefGroup";
static NSString *const kProjectDirPathKey = @"projectDirPath";
static NSString *const kProjectRootKey = @"projectRoot";
static NSString *const kTargetUIDsKey = @"targets";


@implementation FFXCProject

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.attributes = (dictionary[kAttributesKey]) ?: @{};
        self.compatibilityVersion = (dictionary[kCompatibilityVersionKey]) ?: @"";
        self.developmentRegion = (dictionary[kDevelopmentRegionKey]) ?: @"";
        self.hasScannedForEncodings = [dictionary[kHasScannedForEncodingsKey] boolValue];
        self.knownRegions = (dictionary[kKnownRegionsKey]) ?: @[];
        self.mainGroupUID = (dictionary[kMainGroupUIDKey]) ?: @"";
        self.projectRefGroupUID = (dictionary[kProjectRefGroupUIDKey]) ?: @"";
        self.projectDirPath = (dictionary[kProjectDirPathKey]) ?: @"";
        self.projectRoot = (dictionary[kProjectRootKey]) ?: @"";
        self.targetUIDs = (dictionary[kTargetUIDsKey]) ?: @[];
    }
    return self;
}

#pragma mark - Add and Remove Methods
- (void)addKnownRegion:(NSString *)knownRegion
{
    self.knownRegions = [self addObject:knownRegion toArray:self.knownRegions];
}

- (void)removeKnownRegion:(NSString *)knownRegion
{
    self.knownRegions = [self removeObject:knownRegion fromArray:self.knownRegions];
}

- (void)addTargetUID:(NSString *)targetUID
{
    self.targetUIDs = [self addObject:targetUID toArray:self.targetUIDs];
}

- (void)removeTargetUID:(NSString *)targetUID
{
    self.targetUIDs = [self removeObject:targetUID fromArray:self.targetUIDs];
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        [self removeTargetUID:deletedObj.uid];
        if ([self.mainGroupUID isEqualToString:deletedObj.uid]) {
            self.mainGroupUID = @"";
        }
        if ([self.projectRefGroupUID isEqualToString:deletedObj.uid]) {
            self.projectRefGroupUID = @"";
        }
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        self.targetUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.targetUIDs];
        if ([self.mainGroupUID isEqualToString:deletedObj.uid]) {
            self.mainGroupUID = replaceObj.uid ?: @"";
        }
        if ([self.projectRefGroupUID isEqualToString:deletedObj.uid]) {
            self.projectRefGroupUID = replaceObj.uid ?: @"";
        }
    } else if (deletedObj) {
        [self handleObjectDeletedNotification:note];
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.attributes = [aDecoder decodeObjectOfClass:[NSDictionary class] forKey:kAttributesKey];
        self.compatibilityVersion = [aDecoder decodeObjectOfClass:[NSString class] forKey:kCompatibilityVersionKey];
        self.developmentRegion = [aDecoder decodeObjectOfClass:[NSString class] forKey:kDevelopmentRegionKey];
        self.hasScannedForEncodings = [aDecoder decodeBoolForKey:kHasScannedForEncodingsKey];
        self.knownRegions = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kKnownRegionsKey];
        self.mainGroupUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kMainGroupUIDKey];
        self.projectRefGroupUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProjectRefGroupUIDKey];
        self.projectDirPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProjectDirPathKey];
        self.projectRoot = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProjectRootKey];
        self.targetUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kTargetUIDsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.attributes forKey:kAttributesKey];
    [aCoder encodeObject:self.compatibilityVersion forKey:kCompatibilityVersionKey];
    [aCoder encodeObject:self.developmentRegion forKey:kDevelopmentRegionKey];
    [aCoder encodeBool:self.hasScannedForEncodings forKey:kHasScannedForEncodingsKey];
    [aCoder encodeObject:self.knownRegions forKey:kKnownRegionsKey];
    [aCoder encodeObject:self.mainGroupUID forKey:kMainGroupUIDKey];
    [aCoder encodeObject:self.projectRefGroupUID forKey:kProjectRefGroupUIDKey];
    [aCoder encodeObject:self.projectDirPath forKey:kProjectDirPathKey];
    [aCoder encodeObject:self.projectRoot forKey:kProjectRootKey];
    [aCoder encodeObject:self.targetUIDs forKey:kTargetUIDsKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.attributes = [self.attributes copyWithZone:zone];
    copy.compatibilityVersion = [self.compatibilityVersion copyWithZone:zone];
    copy.developmentRegion = [self.developmentRegion copyWithZone:zone];
    copy.hasScannedForEncodings = self.hasScannedForEncodings;
    copy.knownRegions = [self.knownRegions copyWithZone:zone];
    copy.mainGroupUID = [self.mainGroupUID copyWithZone:zone];
    copy.projectRefGroupUID = [self.projectRefGroupUID copyWithZone:zone];
    copy.projectDirPath = [self.projectDirPath copyWithZone:zone];
    copy.projectRoot = [self.projectRoot copyWithZone:zone];
    copy.targetUIDs = [self.targetUIDs copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kAttributesKey,
                      kCompatibilityVersionKey,
                      kDevelopmentRegionKey,
                      kKnownRegionsKey,
                      kMainGroupUIDKey,
                      kProjectRefGroupUIDKey,
                      kProjectDirPathKey,
                      kProjectRootKey,
                      kTargetUIDsKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kHasScannedForEncodingsKey] = (self.hasScannedForEncodings) ? @(1) : @(0);
    
    return dict.copy;
}

@end
