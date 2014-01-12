//
//  FFXCodeProjectFile.h
//
//  Created by Florian Friedrich on 12.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFXcodeObject.h"

@interface FFXCodeProjectFile : NSObject

@property (nonatomic, strong) NSURL *projectFileURL;

@property (nonatomic, strong) NSNumber *archiveVersion;
@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) NSNumber *objectVersion;
@property (nonatomic, strong) NSArray *objects;

@property (nonatomic, strong) FFXcodeObject *rootObject;


- (instancetype)initWithProjectFileURL:(NSURL *)projectFileURL;

- (NSDictionary *)dictionaryRepresentation;

@end
