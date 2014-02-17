//
//  FFXCShellScriptBuildPhase.m
//
//  Created by Florian Friedrich on 5.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCShellScriptBuildPhase.h"

NSString *const kPBXShellScriptBuildPhase = @"PBXShellScriptBuildPhase";
NSString *const kDefaultShellPath = @"/bin/sh";

static NSString *const kInputPathsKey = @"inputPaths";
static NSString *const kOutputPathsKey = @"outputPaths";
static NSString *const kShellPathKey = @"shellPath";
static NSString *const kShellScriptKey = @"shellScript";


@implementation FFXCShellScriptBuildPhase

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.inputPaths = dictionary[kInputPathsKey] ?: @[];
        self.outputPaths = dictionary[kOutputPathsKey] ?: @[];
        self.shellPath = dictionary[kShellPathKey] ?: kDefaultShellPath;
        self.shellScript = dictionary[kShellScriptKey] ?: @"";
        
        self.isa = (self.isa) ?: kPBXShellScriptBuildPhase;
    }
    return self;
}

#pragma mark - Add and Remove Methods
- (void)addInputPath:(NSString *)inputPath
{
    self.inputPaths = [self.inputPaths arrayByAddingObject:inputPath];
}

- (void)removeInputPath:(NSString *)inputPath
{
    NSInteger index = [self.inputPaths indexOfObject:inputPath];
    if (index != NSNotFound) {
        NSMutableArray *mIPs = self.inputPaths.mutableCopy;
        [mIPs removeObjectAtIndex:index];
        self.inputPaths = mIPs.copy;
    }
}

- (void)addOutputPath:(NSString *)outputPath
{
    self.outputPaths = [self.outputPaths arrayByAddingObject:outputPath];
}

- (void)removeOutputPath:(NSString *)outputPath
{
    NSInteger index = [self.outputPaths indexOfObject:outputPath];
    if (index != NSNotFound) {
        NSMutableArray *mOPs = self.outputPaths.mutableCopy;
        [mOPs removeObjectAtIndex:index];
        self.outputPaths = mOPs.copy;
    }
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.inputPaths = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kInputPathsKey];
        self.outputPaths = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kOutputPathsKey];
        self.shellPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kShellPathKey];
        self.shellScript = [aDecoder decodeObjectOfClass:[NSString class] forKey:kShellScriptKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.inputPaths forKey:kInputPathsKey];
    [aCoder encodeObject:self.outputPaths forKey:kOutputPathsKey];
    [aCoder encodeObject:self.shellPath forKey:kShellPathKey];
    [aCoder encodeObject:self.shellScript forKey:kShellScriptKey];
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.inputPaths = [self.inputPaths copyWithZone:zone];
    copy.outputPaths = [self.outputPaths copyWithZone:zone];
    copy.shellPath = [self.shellPath copyWithZone:zone];
    copy.shellScript = [self.shellScript copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kInputPathsKey,
                      kOutputPathsKey,
                      kShellPathKey,
                      kShellScriptKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    
    return dict.copy;
}

@end
