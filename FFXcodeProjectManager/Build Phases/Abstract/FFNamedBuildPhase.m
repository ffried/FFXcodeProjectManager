//
//  FFNamedBuildPhase.m
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFNamedBuildPhase.h"

static NSString *const kBuildPhaseNameKey = @"name";

@implementation FFNamedBuildPhase

- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.name = dictionary[kBuildPhaseNameKey];
    }
    return self;
}

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
                                   name:(NSString *)name
{
    self = [super initWithBuildActionMask:buildActionMask
                                    files:files
       runOnlyForDeploymentPostprocessing:runOnlyForDeploymentPostprocessing];
    if (self) {
        self.name = name;
    }
    return self;
}

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
{
    return [self initWithBuildActionMask:buildActionMask
                                   files:files
      runOnlyForDeploymentPostprocessing:runOnlyForDeploymentPostprocessing
                                    name:nil];
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kBuildPhaseNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name forKey:kBuildPhaseNameKey];
}

#pragma mark - NSCopying
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
    NSArray *keys = @[kBuildPhaseNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
