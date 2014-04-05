//
//  FFXCReferenceProxy.m
//
//  Created by Florian Friedrich on 24.03.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCReferenceProxy.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXReferenceProxy = @"PBXReferenceProxy";

static NSString *const kFileTypeKey = @"fileType";
static NSString *const kRemoteReferenceUIDKey = @"remoteRef";


@implementation FFXCReferenceProxy

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.fileType = (dictionary[kFileTypeKey]) ?: @"";
        self.remoteRefUID = (dictionary[kRemoteReferenceUIDKey]) ?: @"";
        
        if (![self.isa isEqualToString:kPBXReferenceProxy]) self.isa = kPBXReferenceProxy;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.fileType = [aDecoder decodeObjectOfClass:[NSString class] forKey:kFileTypeKey];
        self.remoteRefUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kRemoteReferenceUIDKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.fileType forKey:kFileTypeKey];
    [aCoder encodeObject:self.remoteRefUID forKey:kRemoteReferenceUIDKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.fileType = [self.fileType copyWithZone:zone];
    copy.remoteRefUID = [self.remoteRefUID copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kFileTypeKey,
                      kRemoteReferenceUIDKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
