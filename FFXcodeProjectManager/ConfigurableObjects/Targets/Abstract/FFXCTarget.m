//
//  FFXCTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCTarget.h"

static NSString *const kBuildPhaseUIDsKey = @"buildPhases";
static NSString *const kDependencyUIDsKey = @"dependencies";
static NSString *const kTargetNameKey = @"name";
static NSString *const kProductNameKey = @"productName";


@implementation FFXCTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildPhaseUIDs = (dictionary[kBuildPhaseUIDsKey]) ?: @[];
        self.dependencyUIDs = (dictionary[kDependencyUIDsKey]) ?: @[];
        self.name = (dictionary[kTargetNameKey]) ?: @"";
        self.productName = (dictionary[kProductNameKey]) ?: @"";
    }
    return self;
}

#pragma mark - Methods
- (void)addBuildPhaseUID:(NSString *)buildPhaseUID
{
    self.buildPhaseUIDs = [self.buildPhaseUIDs arrayByAddingObject:buildPhaseUID];
}

- (void)removeBuildPhaseUID:(NSString *)buildPhaseUID
{
    NSInteger index = [self.buildPhaseUIDs indexOfObject:buildPhaseUID];
    if (index != NSNotFound) {
        NSMutableArray *mBPUIDs = self.buildPhaseUIDs.mutableCopy;
        [mBPUIDs removeObjectAtIndex:index];
        self.buildPhaseUIDs = mBPUIDs.copy;
    }
}

- (void)addDependencyUID:(NSString *)dependencyUID
{
    self.dependencyUIDs = [self.dependencyUIDs arrayByAddingObject:dependencyUID];
}

- (void)removeDependencyUID:(NSString *)dependencyUID
{
    NSInteger index = [self.dependencyUIDs indexOfObject:dependencyUID];
    if (index != NSNotFound) {
        NSMutableArray *mDUIDs = self.dependencyUIDs.mutableCopy;
        [mDUIDs removeObjectAtIndex:index];
        self.dependencyUIDs = mDUIDs.copy;
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildPhaseUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildPhaseUIDsKey];
        self.dependencyUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kDependencyUIDsKey];
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kTargetNameKey];
        self.productName = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildPhaseUIDs forKey:kBuildPhaseUIDsKey];
    [aCoder encodeObject:self.dependencyUIDs forKey:kDependencyUIDsKey];
    [aCoder encodeObject:self.name forKey:kTargetNameKey];
    [aCoder encodeObject:self.productName forKey:kProductNameKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildPhaseUIDs = [self.buildPhaseUIDs copyWithZone:zone];
    copy.dependencyUIDs = [self.dependencyUIDs copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.productName = [self.productName copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildPhaseUIDsKey,
                      kDependencyUIDsKey,
                      kTargetNameKey,
                      kProductNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
