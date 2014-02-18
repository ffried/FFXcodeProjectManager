//
//  FFXCContainerItemProxy.m
//
//  Created by Florian Friedrich on 23.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCContainerItemProxy.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXContainerItemProxy = @"PBXContainerItemProxy";

static NSString *const kContainerPortalUIDKey = @"containerPortal";
static NSString *const kProxyTypeKey = @"proxyType";
static NSString *const kRemoteGlobalIDStringKey = @"remoteGlobalIDString";
static NSString *const kRemoteInfoKey = @"remoteInfo";


@implementation FFXCContainerItemProxy

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.containerPortalUID = (dictionary[kContainerPortalUIDKey]) ?: @"";
        self.proxyType = (dictionary[kProxyTypeKey]) ?: @(0);
        self.remoteGlobalIDString = (dictionary[kRemoteGlobalIDStringKey]) ?: @"";
        self.remoteInfo = (dictionary[kRemoteInfoKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXContainerItemProxy;
    }
    return self;
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        if ([self.containerPortalUID isEqualToString:deletedObj.uid]) {
            self.containerPortalUID = @"";
        }
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        if ([self.containerPortalUID isEqualToString:deletedObj.uid]) {
            self.containerPortalUID = replaceObj.uid ?: @"";
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
        self.containerPortalUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kContainerPortalUIDKey];
        self.proxyType = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kProxyTypeKey];
        self.remoteGlobalIDString = [aDecoder decodeObjectOfClass:[NSString class] forKey:kRemoteGlobalIDStringKey];
        self.remoteInfo = [aDecoder decodeObjectOfClass:[NSString class] forKey:kRemoteInfoKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.containerPortalUID forKey:kContainerPortalUIDKey];
    [aCoder encodeObject:self.proxyType forKey:kProxyTypeKey];
    [aCoder encodeObject:self.remoteGlobalIDString forKey:kRemoteGlobalIDStringKey];
    [aCoder encodeObject:self.remoteInfo forKey:kRemoteInfoKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.containerPortalUID = [self.containerPortalUID copyWithZone:zone];
    copy.proxyType = [self.proxyType copyWithZone:zone];
    copy.remoteGlobalIDString = [self.remoteGlobalIDString copyWithZone:zone];
    copy.remoteInfo = [self.remoteInfo copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kContainerPortalUIDKey,
                      kProxyTypeKey,
                      kRemoteGlobalIDStringKey,
                      kRemoteInfoKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
