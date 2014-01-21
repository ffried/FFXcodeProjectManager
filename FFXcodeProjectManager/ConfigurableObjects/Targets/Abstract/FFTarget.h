//
//  FFTarget.h
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFConfigurableObject.h"

@interface FFTarget : FFConfigurableObject

@property (nonatomic, strong) NSArray *buildPhases;
@property (nonatomic, strong) NSArray *dependencies;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *productName;

- (instancetype)initWithBuildConfigurationList:(FFConfigurationList *)buildConfigurationList
                                   buildPhases:(NSArray *)buildPhases
                                  dependencies:(NSArray *)dependencies
                                          name:(NSString *)name
                                   productName:(NSString *)productName;

@end
