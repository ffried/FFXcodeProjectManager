//
//  FFXcodeRunScript.m
//
//  Created by Florian Friedrich on 5.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "FFXcodeRunScript.h"

static NSString *const kNameKey = @"name";
static NSString *const kFilesKey = @"files";
static NSString *const kInputPathsKey = @"inputPaths";
static NSString *const kOutputPathsKey = @"outputPaths";
static NSString *const kRunOnlyForDeploymentPostprocessingKey = @"runOnlyForDeploymentPostprocessing";
static NSString *const kShellPathKey = @"shellPath";
static NSString *const kShellScriptKey = @"shellScript";
static NSString *const kBuildActionMaskKey = @"buildActionMask";

NSUInteger const kDefaultBuildActionMask = 2147483647;
NSString *const kPBXShellScriptBuildPhase = @"PBXShellScriptBuildPhase";
NSString *const kDefaultShellPath = @"/bin/sh";

@implementation FFXcodeRunScript

#pragma mark - Initializer
- (instancetype)initWithUID:(NSString *)uid ofDictionary:(NSDictionary *)dictionary
{
    self = [super initWithUID:uid ofDictionary:dictionary];
    if (self) {
        self.name = dictionary[kNameKey] ?: @"";
        self.files = dictionary[kFilesKey] ?: @[];
        self.inputPaths = dictionary[kInputPathsKey] ?: @[];
        self.outputPaths = dictionary[kOutputPathsKey] ?: @[];
        self.runOnlyForDeploymentPostprocessing = [dictionary[kRunOnlyForDeploymentPostprocessingKey] boolValue] ?: NO;
        self.shellPath = dictionary[kShellPathKey] ?: kDefaultShellPath;
        self.shellScript = dictionary[kShellScriptKey] ?: @"";
        self.buildActionMask = (dictionary[kBuildActionMaskKey]) ?: @(kDefaultBuildActionMask);
        
        self.isa = (self.isa) ?: kPBXShellScriptBuildPhase;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
                       files:(NSArray *)files
                  inputPaths:(NSArray *)inputPaths
                 outputPaths:(NSArray *)outputPaths
runOnlyForDeploymentPostprocessing:(BOOL)runOnlyForDeploymentPostprocessing
                   shellPath:(NSString *)shellPath
                 shellScript:(NSString *)shellScript
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (name) dictionary[kNameKey] = name;
    if (files) dictionary[kFilesKey] = files;
    if (inputPaths) dictionary[kInputPathsKey] = inputPaths;
    if (outputPaths) dictionary[kOutputPathsKey] = outputPaths;
    dictionary[kRunOnlyForDeploymentPostprocessingKey] = [NSNumber numberWithBool:runOnlyForDeploymentPostprocessing];
    if (shellPath) dictionary[kShellPathKey] = shellPath;
    if (shellScript) dictionary[kShellScriptKey] = shellScript;
    return [self initWithUID:nil ofDictionary:dictionary.copy];
}

- (instancetype)init {
    return [self initWithName:nil
                        files:nil
                   inputPaths:nil
                  outputPaths:nil
runOnlyForDeploymentPostprocessing:NO
                    shellPath:nil
                  shellScript:nil];
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buildActionMask = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:kBuildActionMaskKey];
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kNameKey];
        self.files = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kFilesKey];
        self.inputPaths = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kInputPathsKey];
        self.outputPaths = [aDecoder decodeObjectOfClass:[NSArray class] forKey:kOutputPathsKey];
        self.runOnlyForDeploymentPostprocessing = [aDecoder decodeBoolForKey:kRunOnlyForDeploymentPostprocessingKey];
        self.shellPath = [aDecoder decodeObjectOfClass:[NSString class] forKey:kShellPathKey];
        self.shellScript = [aDecoder decodeObjectOfClass:[NSString class] forKey:kShellScriptKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.buildActionMask forKey:kBuildActionMaskKey];
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.files forKey:kFilesKey];
    [aCoder encodeObject:self.inputPaths forKey:kInputPathsKey];
    [aCoder encodeObject:self.outputPaths forKey:kOutputPathsKey];
    [aCoder encodeBool:self.runOnlyForDeploymentPostprocessing forKey:kRunOnlyForDeploymentPostprocessingKey];
    [aCoder encodeObject:self.shellPath forKey:kShellPathKey];
    [aCoder encodeObject:self.shellScript forKey:kShellScriptKey];
}

#pragma mark - Copying
- (instancetype)copyWithZone:(NSZone *)zone
{
    __typeof(self) copy = [super copyWithZone:zone];
    
    copy.buildActionMask = [self.buildActionMask copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.files = [self.files copyWithZone:zone];
    copy.inputPaths = [self.inputPaths copyWithZone:zone];
    copy.outputPaths = [self.outputPaths copyWithZone:zone];
    copy.runOnlyForDeploymentPostprocessing = self.runOnlyForDeploymentPostprocessing;
    copy.shellPath = [self.shellPath copyWithZone:zone];
    copy.shellScript = [self.shellScript copyWithZone:zone];
    
    return copy;
}

#pragma mark - Dictionary Representation
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [super dictionaryRepresentation].mutableCopy;
    NSArray *keys = @[kBuildActionMaskKey,
                      kNameKey,
                      kFilesKey,
                      kInputPathsKey,
                      kOutputPathsKey,
                      kShellPathKey,
                      kShellScriptKey];
    
    [dict addEntriesFromDictionary:[self dictionaryWithValuesForKeys:keys]];
    dict[kRunOnlyForDeploymentPostprocessingKey] = (self.runOnlyForDeploymentPostprocessing) ? @(1) : @(0);
    
    return dict.copy;
}

@end
