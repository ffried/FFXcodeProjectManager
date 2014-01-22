//
//  FFXCExplicitFileReference.h
//
//  Created by Florian Friedrich on 22.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCFileObject.h"

@interface FFXCExplicitFileReference : FFXCFileObject

@property (nonatomic, strong) NSString *explicitFileType;
@property (nonatomic, assign) BOOL includeInIndex;

@end
