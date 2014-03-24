//
//  FFXCVersionGroup.m
//
//  Created by Florian Friedrich on 24.03.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCVersionGroup.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kXCVersionGroup = @"XCVersionGroup";

static NSString *const kCurrentVersionUIDKey = @"currentVersion";
static NSString *const kVersionGroupTypeKey = @"versionGroupType";


@implementation FFXCVersionGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        
        self.currentVersionUID = dictionary[kCurrentVersionUIDKey] ?: @"";
        self.versionGroupType = dictionary[kVersionGroupTypeKey] ?: @"";
        
        if (![self.isa isEqualToString:kXCVersionGroup]) self.isa = kXCVersionGroup;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.currentVersionUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kCurrentVersionUIDKey];
        self.versionGroupType = [aDecoder decodeObjectOfClass:[NSString class] forKey:kVersionGroupTypeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.currentVersionUID forKey:kCurrentVersionUIDKey];
    [aCoder encodeObject:self.versionGroupType forKey:kVersionGroupTypeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.currentVersionUID = [self.currentVersionUID copyWithZone:zone];
    copy.versionGroupType = [self.versionGroupType copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    
    NSArray *keys = @[kCurrentVersionUIDKey,
                      kVersionGroupTypeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
