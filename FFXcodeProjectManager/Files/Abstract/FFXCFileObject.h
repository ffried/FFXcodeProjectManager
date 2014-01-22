//
//  FFXCFileObject.h
//
//  Created by Florian Friedrich on 22.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

extern NSString *const kPBXFileReference;

@interface FFXCFileObject : FFXCObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *sourceTree;

@end
