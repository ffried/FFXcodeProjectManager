//
//  FFNamedGroup.h
//
//  Created by Florian Friedrich on 19.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFGroup.h"

@interface FFNamedGroup : FFGroup

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithChildren:(NSArray *)children sourceTree:(NSString *)sourceTree name:(NSString *)name;

@end