//
//  FFXCGroup.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCGroup.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXGroup = @"PBXGroup";

static NSString *const kChildUIDsKey = @"children";
static NSString *const kGroupSourceTreeKey = @"sourceTree";
static NSString *const kGroupNameKey = @"name";
static NSString *const kGroupPathKey = @"path";


@implementation FFXCGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.childUIDs = (dictionary[kChildUIDsKey]) ?: @[];
        self.sourceTree = (dictionary[kGroupSourceTreeKey]) ?: @"";
        
        self.name = dictionary[kGroupNameKey];
        self.path = dictionary[kGroupPathKey];
        
        self.isa = (self.isa) ?: kPBXGroup;
    }
    return self;
}

#pragma mark - Add and Remove Methods
- (void)addChildUID:(NSString *)childUID
{
    self.childUIDs = [self addObject:childUID toArray:self.childUIDs];
}

- (void)removeChildUID:(NSString *)childUID
{
    self.childUIDs = [self removeObject:childUID fromArray:self.childUIDs];
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        [self removeChildUID:deletedObj.uid];
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        self.childUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.childUIDs];
    } else if (deletedObj) {
        [self handleObjectDeletedNotification:note];
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.childUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kChildUIDsKey];
        self.sourceTree = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupSourceTreeKey];
        
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupNameKey];
        self.path = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupPathKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.childUIDs forKey:kChildUIDsKey];
    [aCoder encodeObject:self.sourceTree forKey:kGroupSourceTreeKey];
    
    [aCoder encodeObject:self.name forKey:kGroupNameKey];
    [aCoder encodeObject:self.path forKey:kGroupPathKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.childUIDs = [self.childUIDs copyWithZone:zone];
    copy.sourceTree = [self.sourceTree copyWithZone:zone];
    
    copy.name = self.name ? [self.name copyWithZone:zone] : nil;
    copy.path = self.path ? [self.path copyWithZone:zone] : nil;
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    
    NSArray *keys = @[kChildUIDsKey,
                      kGroupSourceTreeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    if (self.name) dict[kGroupNameKey] = self.name;
    if (self.path) dict[kGroupPathKey] = self.path;
    
    return dict.copy;
}

@end

