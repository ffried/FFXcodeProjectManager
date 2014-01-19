//
//  FFCopyFilesBuildPhase.h
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFNamedBuildPhase.h"

extern NSString *const kPBXCopyFilesBuildPhase;

@interface FFCopyFilesBuildPhase : FFNamedBuildPhase

@property (nonatomic, strong) NSString *dstPath;
@property (nonatomic, strong) NSNumber *dstSubfolderSpec;

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
                                   name:(NSString *)name
                                dstPath:(NSString *)dstPath
                       dstSubfolderSpec:(NSNumber *)dstSubfolderSpec;

@end
