//
//  FFXCProjectUIDGenerator.m
//
//  Created by Florian Friedrich on 3.1.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCProjectUIDGenerator.h"

static NSString *const kHexCharacters = @"0123456789ABCDEF";


@implementation FFXCProjectUIDGenerator

+ (NSString *)randomXcodeProjectUID
{
    return [[self class] randomXcodeProjectUIDWithLength:kFFXCProjectUIDDefaultLength];
}

+ (NSString *)randomXcodeProjectUIDWithLength:(NSUInteger)length
{
    NSMutableString *uid = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < length; i++) {
        [uid appendFormat:@"%C", [kHexCharacters characterAtIndex:(arc4random() % kHexCharacters.length)]];
    }
    
    return uid.copy;
}

@end
