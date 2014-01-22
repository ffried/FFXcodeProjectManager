//
//  FFXCVariantGroup.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCVariantGroup.h"

NSString *const kPBXVariantGroup = @"PBXVariantGroup";

@implementation FFXCVariantGroup

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        if (![self.isa isEqualToString:kPBXVariantGroup]) self.isa = kPBXVariantGroup;
    }
    return self;
}

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree name:(NSString *)name
{
    self = [super initWithChildren:children sourceTree:sourceTree name:name];
    if (self) {
        if (![self.isa isEqualToString:kPBXVariantGroup]) self.isa = kPBXVariantGroup;
    }
    return self;
}

@end
