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

- (instancetype)initWithBuildConfigurationList:(FFXCConfigurationList *)buildConfigurationList
                                   buildPhases:(NSArray *)buildPhases
                                  dependencies:(NSArray *)dependencies
                                          name:(NSString *)name
                                   productName:(NSString *)productName
                                    buildRules:(NSArray *)buildRules
                              productReference:(FFXCObject *)productReference
                                   productType:(NSString *)productType;

@end
