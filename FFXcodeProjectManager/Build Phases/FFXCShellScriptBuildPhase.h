//
//  FFXCShellScriptBuildPhase.h
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

#import <FFXcodeProjectManager/FFXCNamedBuildPhase.h>

/**
 The isa of a shell script build phase.
 @see FFXCShellScriptBuildPhase
 @see FFXCObject#isa
 */
extern NSString *const kPBXShellScriptBuildPhase;

/**
 Represents a shell script build phase.
 @author Florian Friedrich
 */
@interface FFXCShellScriptBuildPhase : FFXCNamedBuildPhase

/**
 The input paths of the shell script build phase.
 @see FFXCShellScriptBuildPhase#addInputPath:
 @see FFXCShellScriptBuildPhase#removeInputPath:
 */
@property (nonatomic, strong) NSArray *inputPaths;
/**
 The output paths of the shell script build phase.
 @see FFXCShellScriptBuildPhase#addOutputPath:
 @see FFXCShellScriptBuildPhase#removeOutputPath:
 */
@property (nonatomic, strong) NSArray *outputPaths;
/**
 The shell path of the shell script build phase.
 */
@property (nonatomic, strong) NSString *shellPath;
/**
 The shell script of the shell script build phase.
 */
@property (nonatomic, strong) NSString *shellScript;

/**
 Adds an input path to the shell script build phase.
 @param inputPath The inputPath to add.
 @see FFXCShellScriptBuildPhase#inputPaths
 */
- (void)addInputPath:(NSString *)inputPath;
/**
 Removes an input path from the shell script build phase.
 @param inputPath The inputPath to remove.
 @see FFXCShellScriptBuildPhase#inputPaths
 */
- (void)removeInputPath:(NSString *)inputPath;

/**
 Adds an output path to the shell script build phase.
 @param outputPath The outputPath to add.
 @see FFXCShellScriptBuildPhase#outputPaths
 */
- (void)addOutputPath:(NSString *)outputPath;
/**
 Removes an output path from the shell script build phase.
 @param outputPath The outputPath to remove.
 @see FFXCShellScriptBuildPhase#inputPaths
 */
- (void)removeOutputPath:(NSString *)outputPath;

@end
