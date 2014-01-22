//
//  FFXCGroup.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

extern NSString *const kPBXGroup;

@interface FFXCGroup : FFXCObject

@property (nonatomic, strong) NSArray *children;
@property (nonatomic, strong) NSString *sourceTree;

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree;

@end
