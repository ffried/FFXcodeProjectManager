//
//  FFXCAggregateTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCAggregateTarget.h"
#import "FFXCObject+PrivateMethods.h"

NSString *const kPBXAggregateTarget = @"PBXAggregateTarget";


@implementation FFXCAggregateTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.isa = (self.isa) ?: kPBXAggregateTarget;
    }
    return self;
}

@end
