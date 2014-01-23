//
//  FFXCObject.m
//
//  Created by Florian Friedrich on 5.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

static NSString *const kUIDKey = @"uid";
static NSString *const kISAKey = @"isa";

@interface FFXCObject ()

@property (nonatomic, strong, readwrite) NSString *uid;

@end


@implementation FFXCObject

// We need to synthesize this manually because "isa" (without underline) is already in use
@synthesize isa = _isa;

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.uid = (uid) ?: [FFXCProjectUIDGenerator randomXcodeProjectUID];
        self.isa = dictionary[kISAKey];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithUID:nil ofDictionary:nil];
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding { return YES; }

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.uid = [aDecoder decodeObjectOfClass:[NSString class] forKey:kUIDKey];
        self.isa = [aDecoder decodeObjectOfClass:[NSString class] forKey:kISAKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:kUIDKey];
    [aCoder encodeObject:self.isa forKey:kISAKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [[[self class] alloc] init];
    
    // UID not copied as it's unique to one object!
    // It's generated in the init method
    copy.isa = [self.isa copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    return [self dictionaryWithValuesForKeys:@[kISAKey]];
}

@end
