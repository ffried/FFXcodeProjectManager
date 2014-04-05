//
//  FFXCNativeTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCNativeTarget.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXNativeTarget = @"PBXNativeTarget";

static NSString *const kBuildRuleUIDsKey = @"buildRules";
static NSString *const kProductReferenceUIDKey = @"productReference";
static NSString *const kProductTypeKey = @"productType";


@implementation FFXCNativeTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.buildRuleUIDs = (dictionary[kBuildRuleUIDsKey]) ?: @[];
        self.productReferenceUID = (dictionary[kProductReferenceUIDKey]) ?: @"";
        self.productType = (dictionary[kProductTypeKey]) ?: @"";
        
        self.isa = (self.isa) ?: kPBXNativeTarget;
    }
    return self;
}

#pragma mark - Methods
- (void)addBuildRuleUID:(NSString *)buildRuleUID
{
    self.buildRuleUIDs = [self addObject:buildRuleUID toArray:self.buildRuleUIDs];
}

- (void)removeBuildRuleUID:(NSString *)buildRuleUID
{
    self.buildRuleUIDs = [self removeObject:buildRuleUID fromArray:self.buildRuleUIDs];
}

#pragma mark - Notifications
- (void)handleObjectDeletedNotification:(NSNotification *)note
{
    [super handleObjectDeletedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    if (deletedObj) {
        [self removeBuildRuleUID:deletedObj.uid];
        if ([self.productReferenceUID isEqualToString:deletedObj.uid]) {
            self.productReferenceUID = @"";
        }
    }
}

- (void)handleObjectReplacedNotification:(NSNotification *)note
{
    [super handleObjectReplacedNotification:note];
    FFXCObject *deletedObj = note.userInfo[FFXCDeletedObjectUserInfoKey];
    FFXCObject *replaceObj = note.userInfo[FFXCInsertedObjectUserInfoKey];
    if (deletedObj && replaceObj) {
        self.buildRuleUIDs = [self replaceObject:deletedObj.uid withObject:replaceObj.uid inArray:self.buildRuleUIDs];
        if ([self.productReferenceUID isEqualToString:deletedObj.uid]) {
            self.productReferenceUID = replaceObj.uid ?: @"";
        }
    } else if (deletedObj) {
        [self handleObjectDeletedNotification:note];
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildRuleUIDs = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kBuildRuleUIDsKey];
        self.productReferenceUID = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductReferenceUIDKey];
        self.productType = [aDecoder decodeObjectOfClass:[NSString class] forKey:kProductTypeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildRuleUIDs forKey:kBuildRuleUIDsKey];
    [aCoder encodeObject:self.productReferenceUID forKey:kProductReferenceUIDKey];
    [aCoder encodeObject:self.productType forKey:kProductTypeKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildRuleUIDs = [self.buildRuleUIDs copyWithZone:zone];
    copy.productReferenceUID = [self.productReferenceUID copyWithZone:zone];
    copy.productType = [self.productType copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildRuleUIDsKey,
                      kProductReferenceUIDKey,
                      kProductTypeKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
