//
//  FFXCConfigurableObject.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

@class FFXCConfigurationList;
@interface FFXCConfigurableObject : FFXCObject

@property (nonatomic, strong) FFXCConfigurationList *buildConfigurationList;

@end
