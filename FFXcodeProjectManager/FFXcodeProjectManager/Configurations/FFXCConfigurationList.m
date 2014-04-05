//
//  FFXCConfigurationList.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCConfigurationList.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kXCConfigurationList = @"XCConfigurationList";

static NSString *const kBuildConfigurationUIDsKey = @"buildConfigurations";
static NSString *const kDefaultConfigurationIsVisibleKey = @"defaultConfigurationIsVisible";
static NSString *const kDefaultConfigurationNameKey = @"defaultConfigurationName";


@implementation FFXCConfigurationList

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildConfigurationUIDs = (dictionary[kBuildConfigurationUIDsKey]) ?: @[];
        self.defaultConfigurationIsVisible = [dictionary[kDefaultConfigurationIsVisibleKey] boolValue];
        self.defaultConfigurationName = dictionary[kDefaultConfigurationNameKey];
        
        self.isa = (self.isa) ?: kXCConfigurationList;
    }
    return self;
}

#pragma mark - Add and Remove Methods
- (void)addBuildConfigurationUID:(NSString *)buildConfigurationUID
{
    self.buildConfigurationUIDs = [self addObject:buildConfigurationUID toArray:self.buildConfigurationUIDs];
}

- (void)removeBuildConfigurationUID:(NSString *)buildConfigurationUID
{
    self.buildConfigurationUIDs = [self removeObject:buildConfigurationUID fromArray:self.buildConfigurationUIDs];
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        [self removeBuildConfigurationUID:deletedObj.uid];
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        self.buildConfigurationUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.buildConfigurationUIDs];
    } else if (deletedObj) {
        [self handleObjectDeletedNotification:note];
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildConfigurationUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildConfigurationUIDsKey];
        self.defaultConfigurationIsVisible = [aDecoder decodeBoolForKey:kDefaultConfigurationIsVisibleKey];
        self.defaultConfigurationName = [aDecoder decodeObjectOfClass:[NSString class] forKey:kDefaultConfigurationNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildConfigurationUIDs forKey:kBuildConfigurationUIDsKey];
    [aCoder encodeBool:self.defaultConfigurationIsVisible forKey:kDefaultConfigurationIsVisibleKey];
    [aCoder encodeObject:self.defaultConfigurationName forKey:kDefaultConfigurationNameKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildConfigurationUIDs = [self.buildConfigurationUIDs copyWithZone:zone];
    copy.defaultConfigurationIsVisible = self.defaultConfigurationIsVisible;
    copy.defaultConfigurationName = [self.defaultConfigurationName copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildConfigurationUIDsKey,
                      kDefaultConfigurationNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kDefaultConfigurationIsVisibleKey] = (self.defaultConfigurationIsVisible) ? @(1) : @(0);
    
    return dict.copy;
}

@end

