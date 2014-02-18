//
//  FFXCTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCTarget.h"
#import "FFXCObject+PrivateMethods.h"

static NSString *const kBuildPhaseUIDsKey = @"buildPhases";
static NSString *const kDependencyUIDsKey = @"dependencies";
static NSString *const kTargetNameKey = @"name";
static NSString *const kProductNameKey = @"productName";


@implementation FFXCTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildPhaseUIDs = (dictionary[kBuildPhaseUIDsKey]) ?: @[];
        self.dependencyUIDs = (dictionary[kDependencyUIDsKey]) ?: @[];
        self.name = (dictionary[kTargetNameKey]) ?: @"";
        self.productName = (dictionary[kProductNameKey]) ?: @"";
    }
    return self;
}

#pragma mark - Add and Remove Methods
- (void)addBuildPhaseUID:(NSString *)buildPhaseUID
{
    self.buildPhaseUIDs = [self addObject:buildPhaseUID toArray:self.buildPhaseUIDs];
}

- (void)removeBuildPhaseUID:(NSString *)buildPhaseUID
{
    self.buildPhaseUIDs = [self removeObject:buildPhaseUID fromArray:self.buildPhaseUIDs];
}

- (void)addDependencyUID:(NSString *)dependencyUID
{
    self.dependencyUIDs = [self addObject:dependencyUID toArray:self.dependencyUIDs];
}

- (void)removeDependencyUID:(NSString *)dependencyUID
{
    self.dependencyUIDs = [self removeObject:dependencyUID fromArray:self.dependencyUIDs];
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        [self removeBuildPhaseUID:deletedObj.uid];
        [self removeDependencyUID:deletedObj.uid];
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        self.buildPhaseUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.buildPhaseUIDs];
        self.dependencyUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.buildPhaseUIDs];
    } else if (deletedObj) {
        [self handleObjectDeletedNotification:note];
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildPhaseUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildPhaseUIDsKey];
        self.dependencyUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kDependencyUIDsKey];
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kTargetNameKey];
        self.productName = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildPhaseUIDs forKey:kBuildPhaseUIDsKey];
    [aCoder encodeObject:self.dependencyUIDs forKey:kDependencyUIDsKey];
    [aCoder encodeObject:self.name forKey:kTargetNameKey];
    [aCoder encodeObject:self.productName forKey:kProductNameKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildPhaseUIDs = [self.buildPhaseUIDs copyWithZone:zone];
    copy.dependencyUIDs = [self.dependencyUIDs copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.productName = [self.productName copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildPhaseUIDsKey,
                      kDependencyUIDsKey,
                      kTargetNameKey,
                      kProductNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
