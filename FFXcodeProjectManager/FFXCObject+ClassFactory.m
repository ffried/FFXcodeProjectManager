//
//  FFXCObject+ClassFactory.m
//
//  Created by Florian Friedrich on 4.2.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject+ClassFactory.h"

#import "FFXCObjects.h"

static NSString *const kISAKey = @"isa";
static NSString *const kNameKey = @"name";
static NSString *const kPathKey = @"path";
static NSString *const kExplicitFileTypeKey = @"explicitFileType";
static NSString *const kLastKnownFileTypeKey = @"lastKnownFileType";


@implementation FFXCObject (ClassFactory)

+ (Class)classForDictionary:(NSDictionary *)dictionary
{
    NSString *isa = dictionary[kISAKey];
    Class returnClass = nil;
    
    // Build Phases
    if ([isa isEqualToString:kPBXCopyFilesBuildPhase]) {
        returnClass = [FFXCCopyFilesBuildPhase class];
    }
    if ([isa isEqualToString:kPBXFrameworksBuildPhase]) {
        returnClass = [FFXCFrameworksBuildPhase class];
    }
    if ([isa isEqualToString:kPBXHeadersBuildPhase]) {
        returnClass = [FFXCHeadersBuildPhase class];
    }
    if ([isa isEqualToString:kPBXResourcesBuildPhase]) {
        returnClass = [FFXCResourcesBuildPhase class];
    }
    if ([isa isEqualToString:kPBXShellScriptBuildPhase]) {
        returnClass = [FFXCShellScriptBuildPhase class];
    }
    if ([isa isEqualToString:kPBXSourcesBuildPhase]) {
        returnClass = [FFXCSourcesBuildPhase class];
    }
    
    // Configurable Objects
    if ([isa isEqualToString:kPBXProject]) {
        returnClass = [FFXCProject class];
    }
    if ([isa isEqualToString:kPBXAggregateTarget]) {
        returnClass = [FFXCAggregateTarget class];
    }
    if ([isa isEqualToString:kPBXNativeTarget]) {
        returnClass = [FFXCNativeTarget class];
    }
    
    // Configurations
    if ([isa isEqualToString:kXCBuildConfiguration]) {
        returnClass = [FFXCBuildConfiguration class];
    }
    if ([isa isEqualToString:kXCConfigurationList]) {
        returnClass = [FFXCConfigurationList class];
    }
    
    // Files
    if ([isa isEqualToString:kPBXFileReference]) {
        // Needs more checks
        NSString *explicitFileType = dictionary[kExplicitFileTypeKey];
        if (explicitFileType.length) {
            returnClass = [FFXCExplicitFileReference class];
        } else {
            NSString *lastKnownFileType = dictionary[kLastKnownFileTypeKey];
            NSString *name = dictionary[kNameKey];
            if (lastKnownFileType.length && name.length) {
                returnClass = [FFXCNamedFileReference class];
            } else if (lastKnownFileType.length) {
                returnClass = [FFXCKnownFileReference class];
            }
        }
    }
    
    // Groups
    if ([isa isEqualToString:kPBXGroup]) {
        // Needs more checks
        NSString *name = dictionary[kNameKey];
        NSString *path = dictionary[kPathKey];
        if (name.length && !path.length) {
            returnClass = [FFXCNamedGroup class];
        }
        if (!name.length && path.length) {
            returnClass = [FFXCPathGroup class];
        }
    }
    if ([isa isEqualToString:kPBXVariantGroup]) {
        returnClass = [FFXCVariantGroup class];
    }
    
    // Others
    if ([isa isEqualToString:kPBXBuildFile]) {
        returnClass = [FFXCBuildFile class];
    }
    if ([isa isEqualToString:kPBXContainerItemProxy]) {
        returnClass = [FFXCContainerItemProxy class];
    }
    if ([isa isEqualToString:kPBXTargetDependency]) {
        returnClass = [FFXCTargetDependency class];
    }
    
    return returnClass;
}

@end
