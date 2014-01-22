//
//  FFXCSourcesBuildPhase.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCSourcesBuildPhase.h"

NSString *const kPBXSourcesBuildPhase = @"PBXSourcesBuildPhase";

@implementation FFXCSourcesBuildPhase

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.isa = (self.isa) ?: kPBXSourcesBuildPhase;
    }
    return self;
}

@end
