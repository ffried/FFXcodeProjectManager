//
//  FFConfigurableObject.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFConfigurableObject.h"
#import "FFConfigurationList.h"

static NSString *kBuildConfigurationListKey = @"buildConfigurationList";

@implementation FFConfigurableObject

- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildConfigurationList = nil; // TODO: use the factory here
    }
    return self;
}

- (instancetype)initWithBuildConfigurationList:(FFConfigurationList *)buildConfigurationList
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (buildConfigurationList) dict[kBuildConfigurationListKey] = buildConfigurationList;
    return [self initWithUID:nil ofDictionary:dict.copy];
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildConfigurationList = [aDecoder decodeObjectOfClass:[FFConfigurationList class] forKey:kBuildConfigurationListKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildConfigurationList forKey:kBuildConfigurationListKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildConfigurationList = [self.buildConfigurationList copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildConfigurationListKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
