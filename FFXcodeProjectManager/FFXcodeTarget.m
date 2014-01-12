//
//  FFXcodeTarget.m
//
//  Created by Florian Friedrich on 5.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "FFXcodeTarget.h"

static NSString *const kNameKey = @"name";
static NSString *const kBuildConfigurationListKey = @"buildConfigurationList";
static NSString *const kBuildPhasesKey = @"buildPhases";
static NSString *const kBuildRulesKey = @"buildRules";
static NSString *const kDependenciesKey = @"dependencies";
static NSString *const kProductNameKey = @"productName";
static NSString *const kProductReferenceKey = @"productReference";
static NSString *const kProductTypeKey = @"productType";

NSString *const kTargetISA = @"PBXNativeTarget";

@implementation FFXcodeTarget

- (instancetype)initWithUUID:(NSString *)uuid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUUID:uuid ofDictionary:dictionary];
    if (self) {
        self.name = dictionary[kNameKey] ?: @"";
        self.buildConfigurationList = dictionary[kBuildConfigurationListKey] ?: @"";
        self.buildPhases = dictionary[kBuildPhasesKey] ?: @[];
        self.buildRules = dictionary[kBuildRulesKey] ?: @[];
        self.dependencies = dictionary[kDependenciesKey] ?: @[];
        self.productName = dictionary[kProductNameKey] ?: @"";
        self.productReference = dictionary[kProductReferenceKey] ?: @"";
        self.productType = dictionary[kProductTypeKey] ?: @"";
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
      buildConfigurationList:(NSString *)buildConfigurationList
                 buildPhases:(NSArray *)buildPhases
                  buildRules:(NSArray *)buildRules
                dependencies:(NSArray *)dependencies
                 productName:(NSString *)productName
            productReference:(NSString *)productReference
                 productType:(NSString *)productType
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (name) dictionary[kNameKey] = name;
    if (buildConfigurationList) dictionary[kBuildConfigurationListKey] = buildConfigurationList;
    if (buildPhases) dictionary[kBuildPhasesKey] = buildPhases;
    if (buildRules) dictionary[kBuildRulesKey] = buildRules;
    if (dependencies) dictionary[kDependenciesKey] = dependencies;
    if (productName) dictionary[kProductNameKey] = productName;
    if (productReference) dictionary[kProductReferenceKey] = productReference;
    if (productType) dictionary[kProductTypeKey] = productType;
    return [self initWithUUID:nil ofDictionary:dictionary.copy];
}

- (instancetype) init
{
    return [self initWithName:nil
       buildConfigurationList:nil
                  buildPhases:nil
                   buildRules:nil
                 dependencies:nil
                  productName:nil
             productReference:nil
                  productType:nil];
}

#pragma mark - NSCoding
+ (BOOL)supportsSecureCoding { return YES; }

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildConfigurationList = [aDecoder decodeObjectOfClass:[NSString class] forKey:kBuildConfigurationListKey];
        self.buildPhases = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildPhasesKey];
        self.buildRules = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildRulesKey];
        self.dependencies = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kDependenciesKey];
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kNameKey];
        self.productName = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductNameKey];
        self.productReference = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductReferenceKey];
        self.productType = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductTypeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildConfigurationList forKey:kBuildConfigurationListKey];
    [aCoder encodeObject:self.buildPhases forKey:kBuildPhasesKey];
    [aCoder encodeObject:self.buildRules forKey:kBuildRulesKey];
    [aCoder encodeObject:self.dependencies forKey:kDependenciesKey];
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.productName forKey:kProductNameKey];
    [aCoder encodeObject:self.productReference forKey:kProductReferenceKey];
    [aCoder encodeObject:self.productType forKey:kProductTypeKey];
}

#pragma mark - Copying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildConfigurationList = [self.buildConfigurationList copyWithZone:zone];
    copy.buildPhases = [self.buildPhases copyWithZone:zone];
    copy.buildRules = [self.buildRules copyWithZone:zone];
    copy.dependencies = [self.dependencies copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.productName = [self.productName copyWithZone:zone];
    copy.productReference = [self.productReference copyWithZone:zone];
    copy.productType = [self.productType copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildConfigurationListKey,
                      kBuildPhasesKey,
                      kBuildRulesKey,
                      kDependenciesKey,
                      kNameKey,
                      kProductNameKey,
                      kProductReferenceKey,
                      kProductTypeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

#pragma mark - Run Scripts
- (void)addRunScript:(FFXcodeRunScript *)runscript
{
    self.buildPhases = [self.buildPhases arrayByAddingObject:runscript.uuid];
}

- (void)removeRunScript:(FFXcodeRunScript *)runscript
{
    NSMutableArray *buildPhases = self.buildPhases.mutableCopy;
    [self.buildPhases enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString *)obj isEqualToString:runscript.uuid]) {
            [buildPhases removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
    self.buildPhases = buildPhases.copy;
}

@end
