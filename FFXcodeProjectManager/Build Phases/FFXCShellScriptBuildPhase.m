//
//  FFXCShellScriptBuildPhase.m
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
