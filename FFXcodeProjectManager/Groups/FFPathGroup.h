//
//  FFPathGroup.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFGroup.h"

@interface FFPathGroup : FFGroup

@property (nonatomic, strong) NSString *path;

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree path:(NSString *)path;

@end
