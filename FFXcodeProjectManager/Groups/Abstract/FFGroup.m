//
//  FFGroup.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFGroup.h"

NSString *const kPBXGroup = @"PBXGroup";

static NSString *const kChildrenKey = @"children";
static NSString *const kGroupSourceTreeKey = @"sourceTree";

@implementation FFGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.children = (dictionary[kChildrenKey]) ?: @[];
        self.sourceTree = (dictionary[kGroupSourceTreeKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXGroup;
    }
    return self;
}

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (children) dict[kChildrenKey] = children;
    if (sourceTree) dict[kGroupSourceTreeKey] = sourceTree;
    return [self initWithUID:nil ofDictionary:dict.copy];
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.children = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kChildrenKey];
        self.sourceTree = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupSourceTreeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.children forKey:kChildrenKey];
    [aCoder encodeObject:self.sourceTree forKey:kGroupSourceTreeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.children = [self.children copyWithZone:zone];
    copy.sourceTree = [self.sourceTree copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kChildrenKey,
                      kGroupSourceTreeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end

