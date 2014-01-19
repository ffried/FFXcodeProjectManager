//
//  FFNamedGroup.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFNamedGroup.h"

static NSString *const kGroupNameKey = @"name";

@implementation FFNamedGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.name = (dictionary[kGroupNameKey]) ?: @"";
    }
    return self;
}

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree name:(NSString *)name
{
    self = [super initWithChildren:children sourceTree:sourceTree];
    if (self) {
        self.name = (name) ?: @"";
    }
    return self;
}

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree
{
    return [self initWithChildren:children sourceTree:sourceTree name:nil];
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name forKey:kGroupNameKey];
}

#pragma mark - Copying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.name = [self.name copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kGroupNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
