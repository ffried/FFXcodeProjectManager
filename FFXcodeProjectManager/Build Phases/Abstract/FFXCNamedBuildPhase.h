//
//  FFXCNamedBuildPhase.h
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCBuildPhase.h"

// Abstract class!
@interface FFXCNamedBuildPhase : FFXCBuildPhase

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
                                   name:(NSString *)name;

@end
