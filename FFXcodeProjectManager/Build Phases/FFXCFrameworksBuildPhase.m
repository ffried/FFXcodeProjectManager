//
//  FFXCFrameworksBuildPhase.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCFrameworksBuildPhase.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXFrameworksBuildPhase = @"PBXFrameworksBuildPhase";


@implementation FFXCFrameworksBuildPhase

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
