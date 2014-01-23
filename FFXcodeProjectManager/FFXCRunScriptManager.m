//
//  FFXCRunScriptManager.m
//
//  Created by Florian Friedrich on 5.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCRunScriptManager.h"

static id SharedManager = nil;

@interface FFXCRunScriptManager ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *savedRunScripts;

@end


@implementation FFXCRunScriptManager

+ (instancetype)sharedManager
{
    if (SharedManager == nil) {
        SharedManager = [[[self class] alloc] init];
    }
    return SharedManager;
}

- (NSArray *)targetsInProjectFileAtPath:(NSURL *)path
{
    NSMutableDictionary *pbxproj = [[NSMutableDictionary alloc] initWithContentsOfURL:path];
    NSMutableDictionary *objects = pbxproj[@"objects"];
    if (!objects) return nil;
    
    NSMutableArray *targets = [[NSMutableArray alloc] init];
    [objects enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *objIsa = [obj valueForKey:@"isa"];
        if ([objIsa isEqualToString:kPBXNativeTarget]) {
            FFXCNativeTarget *target = [[FFXCNativeTarget alloc] initWithUID:key ofDictionary:obj];
            [targets addObject:target];
        }
    }];
    
    return targets.copy;
}

- (void)addRunScript:(FFXCShellScriptBuildPhase *)runScript
            toTarget:(FFXCNativeTarget *)target
 inProjectFileAtPath:(NSURL *)path
            remember:(BOOL)remember
{
    NSMutableDictionary *pbxproj = [[NSMutableDictionary alloc] initWithContentsOfURL:path];
    NSMutableDictionary *objects = [NSMutableDictionary dictionaryWithDictionary:pbxproj[@"objects"]];
    if (!objects) return;
    
    //[target addRunScript:runScript];
    target.buildPhaseUIDs = [target.buildPhaseUIDs arrayByAddingObject:runScript];
    objects[target.uid] = [target dictionaryRepresentation];
    
    NSDictionary *runscriptDictionary = [runScript dictionaryRepresentation];
    objects[runScript.uid] = runscriptDictionary;
    pbxproj[@"objects"] = objects.copy;
    
    [pbxproj writeToURL:path atomically:YES];
    
    if (remember) {
        NSMutableDictionary *srs = self.savedRunScripts.mutableCopy;
        [srs setObject:runScript forKey:path.absoluteString];
        self.savedRunScripts = srs.copy;
    }
}

- (void)removeRunScript:(FFXCShellScriptBuildPhase *)runScript
             fromTarget:(FFXCNativeTarget *)target
    inProjectFileAtPath:(NSURL *)path
{
    NSMutableDictionary *pbxproj = [[NSMutableDictionary alloc] initWithContentsOfURL:path];
    NSMutableDictionary *objects = [NSMutableDictionary dictionaryWithDictionary:pbxproj[@"objects"]];
    if (!objects) return;
    
    //[target removeRunScript:runScript];
    // TODO: remove the run script
    objects[target.uid] = [target dictionaryRepresentation];
    
    [objects removeObjectForKey:runScript.uid];
    pbxproj[@"objects"] = objects.copy;
    
    [pbxproj writeToURL:path atomically:YES];
    
    NSMutableDictionary *srs = self.savedRunScripts.mutableCopy;
    [srs removeObjectForKey:path.absoluteString];
    self.savedRunScripts = srs.copy;
}

#pragma mark - Persisting Saved Scripts
- (BOOL)writeSavedRunScriptsToFile:(NSURL *)filePath error:(NSError *__autoreleasing *)error
{
    if (self.savedRunScripts.count == 0) return NO;
    
    NSData *savedRunScriptsData = [NSKeyedArchiver archivedDataWithRootObject:self.savedRunScripts];
    return [savedRunScriptsData writeToURL:filePath options:NSDataWritingAtomic error:error];;
}

- (BOOL)loadSavedRunScriptsFromFile:(NSURL *)filePath error:(NSError *__autoreleasing *)error
{
    NSData *savedRunScriptsData = [NSData dataWithContentsOfURL:filePath options:kNilOptions error:error];
    if (!savedRunScriptsData) return NO;
    
    self.savedRunScripts = [NSKeyedUnarchiver unarchiveObjectWithData:savedRunScriptsData];
    return (self.savedRunScripts != nil);
}

@end
