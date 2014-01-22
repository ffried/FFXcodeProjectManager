//
//  FFXCConfigurationList.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCConfigurationList.h"

NSString *const kXCConfigurationList = @"XCConfigurationList";

static NSString *const kBuildConfigurationsKey = @"buildConfigurations";
static NSString *const kDefaultConfigurationIsVisibleKey = @"defaultConfigurationIsVisible";
static NSString *const kDefaultConfigurationNameKey = @"defaultConfigurationName";


@implementation FFXCConfigurationList

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildConfigurations = (dictionary[kBuildConfigurationsKey]) ?: @[];
        self.defaultConfigurationIsVisible = [dictionary[kDefaultConfigurationIsVisibleKey] boolValue];
        self.defaultConfigurationName = dictionary[kDefaultConfigurationNameKey];
        
        self.isa = (self.isa) ?: kXCConfigurationList;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildConfigurations = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildConfigurationsKey];
        self.defaultConfigurationIsVisible = [aDecoder decodeBoolForKey:kDefaultConfigurationIsVisibleKey];
        self.defaultConfigurationName = [aDecoder decodeObjectOfClass:[NSString class] forKey:kDefaultConfigurationNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildConfigurations forKey:kBuildConfigurationsKey];
    [aCoder encodeBool:self.defaultConfigurationIsVisible forKey:kDefaultConfigurationIsVisibleKey];
    [aCoder encodeObject:self.defaultConfigurationName forKey:kDefaultConfigurationNameKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildConfigurations = [self.buildConfigurations copyWithZone:zone];
    copy.defaultConfigurationIsVisible = self.defaultConfigurationIsVisible;
    copy.defaultConfigurationName = [self.defaultConfigurationName copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildConfigurationsKey,
                      kDefaultConfigurationNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kDefaultConfigurationIsVisibleKey] = (self.defaultConfigurationIsVisible) ? @(1) : @(0);
    
    return dict.copy;
}

@end

