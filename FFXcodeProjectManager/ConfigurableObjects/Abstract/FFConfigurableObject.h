//
//  FFConfigurableObject.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXcodeObject.h"

@class FFConfigurationList;
@interface FFConfigurableObject : FFXcodeObject

@property (nonatomic, strong) FFConfigurationList *buildConfigurationList;

- (instancetype)initWithBuildConfigurationList:(FFConfigurationList *)buildConfigurationList;

@end
