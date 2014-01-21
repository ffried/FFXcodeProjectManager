//
//  FFNativeTarget.h
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFTarget.h"

extern NSString *const kPBXNativeTarget;

@interface FFNativeTarget : FFTarget

@property (nonatomic, strong) NSArray *buildRules;
@property (nonatomic, strong) FFXcodeObject *productReference; // TODO: is FFFileReference (or how ever the class will be named)
@property (nonatomic, strong) NSString *productType;

- (instancetype)initWithBuildConfigurationList:(FFConfigurationList *)buildConfigurationList
                                   buildPhases:(NSArray *)buildPhases
                                  dependencies:(NSArray *)dependencies
                                          name:(NSString *)name
                                   productName:(NSString *)productName
                                    buildRules:(NSArray *)buildRules
                              productReference:(FFXcodeObject *)productReference
                                   productType:(NSString *)productType;

@end
