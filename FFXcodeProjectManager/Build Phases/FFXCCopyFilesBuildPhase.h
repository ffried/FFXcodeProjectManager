//
//  FFXCCopyFilesBuildPhase.h
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCNamedBuildPhase.h"

extern NSString *const kPBXCopyFilesBuildPhase;

@interface FFXCCopyFilesBuildPhase : FFXCNamedBuildPhase

@property (nonatomic, strong) NSString *dstPath;
@property (nonatomic, strong) NSNumber *dstSubfolderSpec;

@end
