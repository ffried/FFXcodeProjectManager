//
//  FFXCFileObject.m
//
//  Created by Florian Friedrich on 22.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCFileObject.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXFileReference = @"PBXFileReference";

static NSString *const kFilePathKey = @"path";
static NSString *const kFileSourceTreeKey = @"sourceTree";


@implementation FFXCFileObject

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.path = (dictionary[kFilePathKey]) ?: @"";
        self.sourceTree = (dictionary[kFileSourceTreeKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXFileReference;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.path = [aDecoder decodeObjectOfClass:[NSString class] forKey:kFilePathKey];
        self.sourceTree = [aDecoder decodeObjectOfClass:[NSString class] forKey:kFileSourceTreeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.path forKey:kFilePathKey];
    [aCoder encodeObject:self.sourceTree forKey:kFileSourceTreeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.path = [self.path copyWithZone:zone];
    copy.sourceTree = [self.sourceTree copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kFilePathKey,
                      kFileSourceTreeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
