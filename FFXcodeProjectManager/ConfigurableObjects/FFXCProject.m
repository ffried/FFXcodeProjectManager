//
//  FFXCProject.m
//
//  Created by Florian Friedrich on 20.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCProject.h"
#import "FFXCGroup.h"

NSString *const kPBXProject = @"PBXProject";

static NSString *const kAttributesKey = @"attributes";
static NSString *const kCompatibilityVersionKey = @"compatibilityVersion";
static NSString *const kDevelopmentRegionKey = @"developmentRegion";
static NSString *const kHasScannedForEncodingsKey = @"hasScannedForEncodings";
static NSString *const kKnownRegionsKey = @"knownRegions";
static NSString *const kMainGroupKey = @"mainGroup";
static NSString *const kProjectRefGroupKey = @"projectRefGroup";
static NSString *const kProjectDirPathKey = @"projectDirPath";
static NSString *const kProjectRootKey = @"projectRoot";
static NSString *const kTargetsKey = @"targets";

@implementation FFXCProject

- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.attributes = (dictionary[kAttributesKey]) ?: @{};
        self.compatibilityVersion = (dictionary[kCompatibilityVersionKey]) ?: @"";
        self.developmentRegion = (dictionary[kDevelopmentRegionKey]) ?: @"";
        self.hasScannedForEncodings = [dictionary[kHasScannedForEncodingsKey] boolValue];
        self.knownRegions = (dictionary[kKnownRegionsKey]) ?: @[];
        self.mainGroup = dictionary[kMainGroupKey];
        self.projectRefGroup = dictionary[kProjectRefGroupKey];
        self.projectDirPath = (dictionary[kProjectDirPathKey]) ?: @"";
        self.projectRoot = (dictionary[kProjectRootKey]) ?: @"";
        self.targets = (dictionary[kTargetsKey]) ?: @[];
    }
    return self;
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
        self.mainGroup = [aDecoder decodeObjectOfClass:[FFXCGroup class] forKey:kMainGroupKey];
        self.projectRefGroup = [aDecoder decodeObjectOfClass:[FFXCGroup class] forKey:kProjectRefGroupKey];
        self.projectDirPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProjectDirPathKey];
        self.projectRoot = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProjectRootKey];
        self.targets = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kTargetsKey];
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
    [aCoder encodeObject:self.mainGroup forKey:kMainGroupKey];
    [aCoder encodeObject:self.projectRefGroup forKey:kProjectRefGroupKey];
    [aCoder encodeObject:self.projectDirPath forKey:kProjectDirPathKey];
    [aCoder encodeObject:self.projectRoot forKey:kProjectRootKey];
    [aCoder encodeObject:self.targets forKey:kTargetsKey];
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
    copy.mainGroup = [self.mainGroup copyWithZone:zone];
    copy.projectRefGroup = [self.projectRefGroup copyWithZone:zone];
    copy.projectDirPath = [self.projectDirPath copyWithZone:zone];
    copy.projectRoot = [self.projectRoot copyWithZone:zone];
    copy.targets = [self.targets copyWithZone:zone];
    
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
                      kMainGroupKey,
                      kProjectRefGroupKey,
                      kProjectDirPathKey,
                      kProjectRootKey,
                      kTargetsKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kHasScannedForEncodingsKey] = (self.hasScannedForEncodings) ? @(1) : @(0);
    
    return dict.copy;
}

@end
