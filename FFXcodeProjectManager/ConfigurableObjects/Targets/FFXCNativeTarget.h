//
//  FFXCNativeTarget.h
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCTarget.h"

extern NSString *const kPBXNativeTarget;

@interface FFXCNativeTarget : FFXCTarget

@property (nonatomic, strong) NSArray *buildRules;
@property (nonatomic, strong) FFXCObject *productReference; // TODO: is FFXCFileReference (or how ever the class will be named)
@property (nonatomic, strong) NSString *productType;

@end
