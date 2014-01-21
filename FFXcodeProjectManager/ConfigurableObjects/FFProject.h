//
//  FFProject.h
//
//  Created by Florian Friedrich on 20.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFConfigurableObject.h"

extern NSString *const kPBXProject;

@class FFGroup;
@interface FFProject : FFConfigurableObject

@property (nonatomic, strong) NSDictionary *attributes; // contains keys like "CLASSPREFIX", "ORGANIZATIONNAME", "TargetAttributes" (which is a dict as well), etc.
@property (nonatomic, strong) NSString *compatibilityVersion;
@property (nonatomic, strong) NSString *developmentRegion;
@property (nonatomic, assign) BOOL hasScannedForEncodings;
@property (nonatomic, strong) NSArray *knownRegions; // Strings "en", "Base", etc.
@property (nonatomic, strong) FFGroup *mainGroup;
@property (nonatomic, strong) FFGroup *projectRefGroup;
@property (nonatomic, strong) NSString *projectDirPath;
@property (nonatomic, strong) NSString *projectRoot;
@property (nonatomic, strong) NSArray *targets;

- (instancetype)initWithBuildConfigurationList:(FFConfigurationList *)buildConfigurationList
                                    attributes:(NSDictionary *)attributes
                          compatibilityVersion:(NSString *)compatibilityVersion
                             developmentRegion:(NSString *)developmentRegion
                        hasScannedForEncodings:(BOOL)hasScannedForEncodings
                                  knownRegions:(NSArray *)knownRegions
                                     mainGroup:(FFGroup *)mainGroup
                               projectRefGroup:(FFGroup *)projectRefGroup
                                projectDirPath:(NSString *)projectDirPath
                                   projectRoot:(NSString *)projectRoot
                                       targets:(NSArray *)targets;

@end
