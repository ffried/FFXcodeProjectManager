//
//  FFXCResourcesBuildPhase.m
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCResourcesBuildPhase.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXResourcesBuildPhase = @"PBXResourcesBuildPhase";


@implementation FFXCResourcesBuildPhase

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.isa = (self.isa) ?: kPBXResourcesBuildPhase;
    }
    return self;
}

@end
