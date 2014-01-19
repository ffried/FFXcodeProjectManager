//
//  FFFrameworksBuildPhase.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFFrameworksBuildPhase.h"

NSString *const kPBXFrameworksBuildPhase = @"PBXFrameworksBuildPhase";

@implementation FFFrameworksBuildPhase

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.isa = (self.isa) ?: kPBXFrameworksBuildPhase;
    }
    return self;
}

@end
