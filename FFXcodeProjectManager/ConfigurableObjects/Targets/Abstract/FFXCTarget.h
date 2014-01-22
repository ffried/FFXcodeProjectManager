//
//  FFXCTarget.h
//
//  Created by Florian Friedrich on 21.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCConfigurableObject.h"

@interface FFXCTarget : FFXCConfigurableObject

@property (nonatomic, strong) NSArray *buildPhases;
@property (nonatomic, strong) NSArray *dependencies;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *productName;

@end
