//
//  FFConfigurationList.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXcodeObject.h"

extern NSString *const kXCConfigurationList;

@interface FFConfigurationList : FFXcodeObject

@property (nonatomic, strong) NSArray *buildConfigurations;
@property (nonatomic, assign) BOOL defaultConfigurationIsVisible;
@property (nonatomic, strong) NSString *defaultConfigurationName;

- (instancetype)initWithBuildConfigurations:(NSArray *)buildConfigurations
              defaultConfigurationIsVisible:(BOOL)defaultConfigurationIsVisible
                   defaultConfigurationName:(NSString *)defaultConfigurationName;

@end
