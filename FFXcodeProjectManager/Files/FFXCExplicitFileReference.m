//
//  FFXCExplicitFileReference.m
//
//  Created by Florian Friedrich on 22.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCExplicitFileReference.h"

static NSString *const kExplicitFileTypeKey = @"explicitFileType";
static NSString *const kIncludeInIndexKey = @"includeInIndex";


@implementation FFXCExplicitFileReference

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.explicitFileType = (dictionary[kExplicitFileTypeKey]) ?: @"";
        self.includeInIndex = [dictionary[kIncludeInIndexKey] boolValue];
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.explicitFileType = [aDecoder decodeObjectOfClass:[NSString class] forKey:kExplicitFileTypeKey];
        self.includeInIndex = [aDecoder decodeBoolForKey:kIncludeInIndexKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.explicitFileType forKey:kExplicitFileTypeKey];
    [aCoder encodeBool:self.includeInIndex forKey:kIncludeInIndexKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.explicitFileType = [self.explicitFileType copyWithZone:zone];
    copy.includeInIndex = self.includeInIndex;
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kExplicitFileTypeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kIncludeInIndexKey] = (self.includeInIndex) ? @(1) : @(0);
    
    return dict.copy;
}

@end
