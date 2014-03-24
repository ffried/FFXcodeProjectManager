//
//  FFXCReferenceProxy.h
//
//  Created by Florian Friedrich on 24.03.14.
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

#import <FFXcodeProjectManager/FFXCFileObject.h>

/**
 The isa of a reference proxy.
 @see FFXCReferenceProxy
 @see FFXCObject#isa
 */
extern NSString *const kPBXReferenceProxy;

/**
 Represents a reference proxy.
 @author Florian Friedrich
 */
@interface FFXCReferenceProxy : FFXCFileObject

/**
 The type of the file.
 */
@property (nonatomic, strong) NSString *fileType;
/**
 The UID of the remote reference.
 */
@property (nonatomic, strong) NSString *remoteRefUID;

@end
