//
//  FFXCTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCTarget.h"

static NSString *const kBuildPhasesKey = @"buildPhases";
static NSString *const kDependenciesKey = @"dependencies";
static NSString *const kTargetNameKey = @"name";
static NSString *const kProductNameKey = @"productName";

@implementation FFXCTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildPhases = (dictionary[kBuildPhasesKey]) ?: @[];
        self.dependencies = (dictionary[kDependenciesKey]) ?: @[];
        self.name = (dictionary[kTargetNameKey]) ?: @"";
        self.productName = (dictionary[kProductNameKey]) ?: @"";
    }
    return self;
}

- (instancetype)initWithBuildConfigurationList:(FFXCConfigurationList *)buildConfigurationList
                                   buildPhases:(NSArray *)buildPhases
                                  dependencies:(NSArray *)dependencies
                                          name:(NSString *)name
                                   productName:(NSString *)productName
{
    self = [super initWithBuildConfigurationList:buildConfigurationList];
    if (self) {
        self.buildPhases = (buildPhases) ?: @[];
        self.dependencies = (dependencies) ?: @[];
        self.name = (name) ?: @"";
        self.productName =  (productName) ?: @"";
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildPhases = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildPhasesKey];
        self.dependencies = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kDependenciesKey];
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kTargetNameKey];
        self.productName = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildPhases forKey:kBuildPhasesKey];
    [aCoder encodeObject:self.dependencies forKey:kDependenciesKey];
    [aCoder encodeObject:self.name forKey:kTargetNameKey];
    [aCoder encodeObject:self.productName forKey:kProductNameKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildPhases = [self.buildPhases copyWithZone:zone];
    copy.dependencies = [self.dependencies copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.productName = [self.productName copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildPhasesKey,
                      kDependenciesKey,
                      kTargetNameKey,
                      kProductNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
