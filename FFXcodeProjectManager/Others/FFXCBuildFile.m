//
//  FFXCBuildFile.m
//
//  Created by Florian Friedrich on 23.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCBuildFile.h"

NSString *const kPBXBuildFile = @"PBXBuildFile";

static NSString *const kFileRefUIDKey = @"fileRef";


@implementation FFXCBuildFile

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.fileRefUID = (dictionary[kFileRefUIDKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXBuildFile;
    }
    return self;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.fileRefUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kFileRefUIDKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.fileRefUID forKey:kFileRefUIDKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.fileRefUID = [self.fileRefUID copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kFileRefUIDKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
