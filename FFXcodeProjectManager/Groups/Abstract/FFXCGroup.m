//
//  FFXCGroup.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCGroup.h"

NSString *const kPBXGroup = @"PBXGroup";

static NSString *const kChildrenUIDsKey = @"children";
static NSString *const kGroupSourceTreeKey = @"sourceTree";


@implementation FFXCGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.childrenUIDs = (dictionary[kChildrenUIDsKey]) ?: @[];
        self.sourceTree = (dictionary[kGroupSourceTreeKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXGroup;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.childrenUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kChildrenUIDsKey];
        self.sourceTree = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupSourceTreeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.childrenUIDs forKey:kChildrenUIDsKey];
    [aCoder encodeObject:self.sourceTree forKey:kGroupSourceTreeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.childrenUIDs = [self.childrenUIDs copyWithZone:zone];
    copy.sourceTree = [self.sourceTree copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kChildrenUIDsKey,
                      kGroupSourceTreeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end

