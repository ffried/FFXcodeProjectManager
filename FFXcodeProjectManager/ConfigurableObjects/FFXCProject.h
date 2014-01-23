//
//  FFXCProject.h
//
//  Created by Florian Friedrich on 20.1.14.
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

#import "FFXCConfigurableObject.h"

extern NSString *const kPBXProject;

@interface FFXCProject : FFXCConfigurableObject

@property (nonatomic, strong) NSDictionary *attributes; // contains keys like "CLASSPREFIX", "ORGANIZATIONNAME", "TargetAttributes" (which is a dict as well), etc.
@property (nonatomic, strong) NSString *compatibilityVersion;
@property (nonatomic, strong) NSString *developmentRegion;
@property (nonatomic, assign) BOOL hasScannedForEncodings;
@property (nonatomic, strong) NSArray *knownRegions; // Strings "en", "Base", etc.
@property (nonatomic, strong) NSString *mainGroupUID;
@property (nonatomic, strong) NSString *projectRefGroupUID;
@property (nonatomic, strong) NSString *projectDirPath;
@property (nonatomic, strong) NSString *projectRoot;
@property (nonatomic, strong) NSArray *targetUIDs;

@end
