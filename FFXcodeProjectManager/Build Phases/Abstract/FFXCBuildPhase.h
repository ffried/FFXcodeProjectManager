//
//  FFXCBuildPhase.h
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

extern NSUInteger const kDefaultBuildActionMask;

// Abstract class!
@interface FFXCBuildPhase : FFXCObject

@property (nonatomic, strong) NSNumber *buildActionMask;
@property (nonatomic, strong) NSArray *files;
@property (nonatomic, assign) BOOL runOnlyForDeploymentPostprocessing;

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing;

@end
