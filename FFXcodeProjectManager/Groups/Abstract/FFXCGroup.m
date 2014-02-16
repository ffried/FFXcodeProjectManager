//
//  FFXCGroup.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCGroup.h"

NSString *const kPBXGroup = @"PBXGroup";

static NSString *const kChildUIDsKey = @"children";
static NSString *const kGroupSourceTreeKey = @"sourceTree";


@implementation FFXCGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.childUIDs = (dictionary[kChildUIDsKey]) ?: @[];
        self.sourceTree = (dictionary[kGroupSourceTreeKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXGroup;
    }
    return self;
}

#pragma mark - Methods
- (void)addChildUID:(NSString *)childUID
{
    self.childUIDs = [self.childUIDs arrayByAddingObject:childUID];
}

- (void)removeChildUID:(NSString *)childUID
{
    NSInteger index = [self.childUIDs indexOfObject:childUID];
    if (index != NSNotFound) {
        NSMutableArray *mCUIDs = self.childUIDs.mutableCopy;
        [mCUIDs removeObject:childUID];
        self.childUIDs = mCUIDs.copy;
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.childUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kChildUIDsKey];
        self.sourceTree = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupSourceTreeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.childUIDs forKey:kChildUIDsKey];
    [aCoder encodeObject:self.sourceTree forKey:kGroupSourceTreeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.childUIDs = [self.childUIDs copyWithZone:zone];
    copy.sourceTree = [self.sourceTree copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kChildUIDsKey,
                      kGroupSourceTreeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end

