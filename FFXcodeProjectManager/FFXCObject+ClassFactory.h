//
//  FFXCObject+ClassFactory.h
//
//  Created by Florian Friedrich on 4.2.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObject.h"

@interface FFXCObject (ClassFactory)

+ (Class)classForDictionary:(NSDictionary *)dictionary;

@end
