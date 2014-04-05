//
//  FFXCNamedFileReference.m
//
//  Created by Florian Friedrich on 22.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCNamedFileReference.h"
#import "FFXCObject+PrivateMethods.h"

static NSString *const kFileNameKey = @"name";


@implementation FFXCNamedFileReference

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.name = (dictionary[kFileNameKey]) ?: @"";
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kFileNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name forKey:kFileNameKey];
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
    NSArray *keys = @[kFileNameKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
