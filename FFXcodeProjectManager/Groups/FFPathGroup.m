//
//  FFPathGroup.m
//  FFXcodeProjectManager Sample
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFPathGroup.h"

static NSString *const kGroupPathKey = @"path";

@implementation FFPathGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.path = (dictionary[kGroupPathKey]) ?: @"";
    }
    return self;
}

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree path:(NSString *)path
{
    self = [super initWithChildren:children sourceTree:sourceTree];
    if (self) {
        self.path = (path) ?: @"";
    }
    return self;
}

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree
{
    return [self initWithChildren:children sourceTree:sourceTree path:nil];
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.path = [aDecoder decodeObjectOfClass:[NSString class] forKey:kGroupPathKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.path forKey:kGroupPathKey];
}

#pragma mark - Copying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.path = [self.path copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kGroupPathKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
