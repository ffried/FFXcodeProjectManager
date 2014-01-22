//
//  FFXCConfigurationList.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

extern NSString *const kXCConfigurationList;

@interface FFXCConfigurationList : FFXCObject

@property (nonatomic, strong) NSArray *buildConfigurations;
@property (nonatomic, assign) BOOL defaultConfigurationIsVisible;
@property (nonatomic, strong) NSString *defaultConfigurationName;

- (instancetype)initWithBuildConfigurations:(NSArray *)buildConfigurations
              defaultConfigurationIsVisible:(BOOL)defaultConfigurationIsVisible
                   defaultConfigurationName:(NSString *)defaultConfigurationName;

@end
