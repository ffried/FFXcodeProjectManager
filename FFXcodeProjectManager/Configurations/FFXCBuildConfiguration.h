//
//  FFXCBuildConfiguration.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

extern NSString *const kXCBuildConfiguration;

@interface FFXCBuildConfiguration : FFXCObject

@property (nonatomic, strong) NSDictionary *buildSettings;
@property (nonatomic, strong) NSString *name;

@end
