//
//  FFCopyFilesBuildPhase.m
//
//  Created by Florian Friedrich on 18.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFCopyFilesBuildPhase.h"

NSString *const kPBXCopyFilesBuildPhase = @"PBXCopyFilesBuildPhase";

static NSString *const kDstPathKey = @"dstPath";
static NSString *const kDstSubfolderSpecKey = @"dstSubfolderSpec";

// TODO: Maybe an enum is better here:
// http://stackoverflow.com/questions/5684583/anyone-had-success-with-copy-files-build-phases-in-xcode-4-templates
static NSUInteger const kDefaultDstSubfolderSpec = 0;

@implementation FFCopyFilesBuildPhase

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.dstPath = dictionary[kDstPathKey] ?: @"";
        self.dstSubfolderSpec = dictionary[kDstSubfolderSpecKey] ?: @(kDefaultDstSubfolderSpec);
        
        self.isa = (self.isa) ?: kPBXCopyFilesBuildPhase;
    }
    return self;
}

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
                                   name:(NSString *)name
                                dstPath:(NSString *)dstPath
                       dstSubfolderSpec:(NSNumber *)dstSubfolderSpec
{
    self = [super initWithBuildActionMask:buildActionMask files:files runOnlyForDeploymentPostprocessing:runOnlyForDeploymentPostprocessing name:name];
    if (self) {
        self.dstPath = (dstPath) ?: @"";
        self.dstSubfolderSpec = (dstSubfolderSpec) ?: @(kDefaultDstSubfolderSpec);
    }
    return self;
}

- (instancetype)initWithBuildActionMask:(NSNumber *)buildActionMask
                                  files:(NSArray *)files
     runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
                                   name:(NSString *)name
{
    return [self initWithBuildActionMask:buildActionMask
                                   files:files
      runOnlyForDeploymentPostprocessing:runOnlyForDeploymentPostprocessing
                                    name:name
                                 dstPath:nil
                        dstSubfolderSpec:nil];
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dstPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kDstPathKey];
        self.dstSubfolderSpec = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kDstSubfolderSpecKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.dstPath forKey:kDstPathKey];
    [aCoder encodeObject:self.dstSubfolderSpec forKey:kDstSubfolderSpecKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.dstPath = [self.dstPath copyWithZone:zone];
    copy.dstSubfolderSpec = [self.dstSubfolderSpec copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kDstPathKey,
                      kDstSubfolderSpecKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
