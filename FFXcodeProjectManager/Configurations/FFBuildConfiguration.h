//
//  FFBuildConfiguration.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXcodeObject.h"

extern NSString *const kXCBuildConfiguration;

@interface FFBuildConfiguration : FFXcodeObject

@property (nonatomic, strong) NSDictionary *buildSettings;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithBuildSettigs:(NSDictionary *)buildSettings name:(NSString *)name;

@end
