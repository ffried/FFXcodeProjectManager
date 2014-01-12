//
//  FFXcodeTarget.h
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

#import <Foundation/Foundation.h>
#import "FFXcodeObject.h"
#import "FFXcodeRunScript.h"

extern NSString *const kTargetISA;

@interface FFXcodeTarget : FFXcodeObject

@property (nonatomic, strong) NSString *buildConfigurationList;
@property (nonatomic, strong) NSArray *buildPhases;
@property (nonatomic, strong) NSArray *buildRules;
@property (nonatomic, strong) NSArray *dependencies;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productReference;
@property (nonatomic, strong) NSString *productType;

- (instancetype)initWithName:(NSString *)name
      buildConfigurationList:(NSString *)buildConfigurationList
                 buildPhases:(NSArray *)buildPhases
                  buildRules:(NSArray *)buildRules
                dependencies:(NSArray *)dependencies
                 productName:(NSString *)productName
            productReference:(NSString *)productReference
                 productType:(NSString *)productType;

- (void)addRunScript:(FFXcodeRunScript *)runscript;
- (void)removeRunScript:(FFXcodeRunScript *)runscript;

@end
