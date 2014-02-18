//
//  FFXCTargetDependency.m
//
//  Created by Florian Friedrich on 23.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCTargetDependency.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXTargetDependency = @"PBXTargetDependency";

static NSString *const kTargetUIDKey = @"target";
static NSString *const kTargetProxyUIDKey = @"targetProxy";


@implementation FFXCTargetDependency

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.targetUID = (dictionary[kTargetUIDKey]) ?: @"";
        self.targetProxyUID = (dictionary[kTargetProxyUIDKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXTargetDependency;
    }
    return self;
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        if ([self.targetUID isEqualToString:deletedObj.uid]) {
            self.targetUID = @"";
        }
        if ([self.targetProxyUID isEqualToString:deletedObj.uid]) {
            self.targetProxyUID = @"";
        }
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        if ([self.targetUID isEqualToString:deletedObj.uid]) {
            self.targetUID = replaceObj.uid ?: @"";
        }
        if ([self.targetProxyUID isEqualToString:deletedObj.uid]) {
            self.targetProxyUID = replaceObj.uid ?: @"";
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
        self.targetUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kTargetUIDKey];
        self.targetProxyUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kTargetProxyUIDKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.targetUID forKey:kTargetUIDKey];
    [aCoder encodeObject:self.targetProxyUID forKey:kTargetProxyUIDKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.targetUID = [self.targetUID copyWithZone:zone];
    copy.targetProxyUID = [self.targetProxyUID copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kTargetUIDKey,
                      kTargetProxyUIDKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
