//
//  FFXCNativeTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCNativeTarget.h"

NSString *const kPBXNativeTarget = @"PBXNativeTarget";

static NSString *const kBuildRulesKey = @"buildRules";
static NSString *const kProductReferenceKey = @"productReference";
static NSString *const kProductTypeKey = @"productType";

@implementation FFXCNativeTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildRules = (dictionary[kBuildRulesKey]) ?: @[];
        self.productReference = dictionary[kProductReferenceKey];
        self.productType = (dictionary[kProductTypeKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXNativeTarget;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildRules = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildRulesKey];
        self.productReference = [aDecoder decodeObjectOfClass:[FFXCObject class] forKey:kProductReferenceKey];
        self.productType = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductTypeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildRules forKey:kBuildRulesKey];
    [aCoder encodeObject:self.productReference forKey:kProductReferenceKey];
    [aCoder encodeObject:self.productType forKey:kProductTypeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildRules = [self.buildRules copyWithZone:zone];
    copy.productReference = [self.productReference copyWithZone:zone];
    copy.productType = [self.productType copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildRulesKey,
                      kProductReferenceKey,
                      kProductTypeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
