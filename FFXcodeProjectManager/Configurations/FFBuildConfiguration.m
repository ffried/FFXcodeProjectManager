//
//  FFBuildConfiguration.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFBuildConfiguration.h"

NSString *const kXCBuildConfiguration = @"XCBuildConfiguration";

static NSString *const kBuildSettingsKey = @"buildSettings";
static NSString *const kBuildConfigurationNameKey = @"name";

@implementation FFBuildConfiguration

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildSettings = (dictionary[kBuildSettingsKey]) ?: @{};
        self.name = (dictionary[kBuildConfigurationNameKey]) ?: @"";
        
        self.isa = (self.isa) ?: kXCBuildConfiguration;
    }
    return self;
}

- (instancetype)initWithBuildSettigs:(NSDictionary *)buildSettings name:(NSString *)name
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (buildSettings) dictionary[kBuildSettingsKey] = buildSettings;
    if (name) dictionary[kBuildConfigurationNameKey] = name;
    return [self initWithUID:nil ofDictionary:dictionary.copy];
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildSettings = [aDecoder decodeObjectOfClass:[NSDictionary class] forKey:kBuildSettingsKey];
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kBuildConfigurationNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildSettings forKey:kBuildSettingsKey];
    [aCoder encodeObject:self.name forKey:kBuildConfigurationNameKey];
}

#pragma mark - Copying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildSettings = [self.buildSettings copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildSettingsKey,
                      kBuildConfigurationNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
