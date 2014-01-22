//
//  FFXCProject.h
//
//  Created by Florian Friedrich on 20.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCConfigurableObject.h"

extern NSString *const kPBXProject;

@class FFXCGroup;

@interface FFXCProject : FFXCConfigurableObject

@property (nonatomic, strong) NSDictionary *attributes; // contains keys like "CLASSPREFIX", "ORGANIZATIONNAME", "TargetAttributes" (which is a dict as well), etc.
@property (nonatomic, strong) NSString *compatibilityVersion;
@property (nonatomic, strong) NSString *developmentRegion;
@property (nonatomic, assign) BOOL hasScannedForEncodings;
@property (nonatomic, strong) NSArray *knownRegions; // Strings "en", "Base", etc.
@property (nonatomic, strong) FFXCGroup *mainGroup;
@property (nonatomic, strong) FFXCGroup *projectRefGroup;
@property (nonatomic, strong) NSString *projectDirPath;
@property (nonatomic, strong) NSString *projectRoot;
@property (nonatomic, strong) NSArray *targets;

@end
