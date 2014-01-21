//
//  FFAggregateTarget.m
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFAggregateTarget.h"

NSString *const kPBXAggregateTarget = @"PBXAggregateTarget";

@implementation FFAggregateTarget

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.isa = (self.isa) ?: kPBXAggregateTarget;
    }
    return self;
}

- (instancetype)initWithBuildConfigurationList:(FFConfigurationList *)buildConfigurationList
                                   buildPhases:(NSArray *)buildPhases
                                  dependencies:(NSArray *)dependencies
                                          name:(NSString *)name
                                   productName:(NSString *)productName
{
    self = [super initWithBuildConfigurationList:buildConfigurationList
                                     buildPhases:buildPhases
                                    dependencies:dependencies
                                            name:name
                                     productName:productName];
    if (self) {
        self.isa = (self.isa) ?: kPBXAggregateTarget;
    }
    return self;
}

@end