//
//  FFXCNativeTarget.h
//
//  Created by Florian Friedrich on 21.1.14.
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

#import <FFXcodeProjectManager/FFXCTarget.h>

/**
 The isa of a native target.
 @see FFXCNativeTarget
 @see FFXCObject#isa
 */
extern NSString *const kPBXNativeTarget;

/**
 Represents a native target.
 @author Florian Friedrich
 */
@interface FFXCNativeTarget : FFXCTarget

/**
 The UID of the build rule.
 @see FFXCNativeTarget#addBuildRuleUID:
 @see FFXCNativeTarget#removeBuildRuleUID:
 */
@property (nonatomic, strong) NSArray *buildRuleUIDs;
/**
 The UID of the product reference.
 */
@property (nonatomic, strong) NSString *productReferenceUID;
/**
 The type of the product.
 */
@property (nonatomic, strong) NSString *productType;

/**
 Adds the UID of a build rule.
 @param buildRuleUID The UID of the build rule to add.
 @see FFXCNativeTarget#buildRuleUIDs
 */
- (void)addBuildRuleUID:(NSString *)buildRuleUID;
/**
 Removes the UID of a build rule.
 @param buildRuleUID The UID of the build rule to remove.
 @see FFXCNativeTarget#buildRuleUIDs
 */
- (void)removeBuildRuleUID:(NSString *)buildRuleUID;

@end
