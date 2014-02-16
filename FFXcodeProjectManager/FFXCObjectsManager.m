//
//  FFXCObjectsManager.m
//
//  Created by Florian Friedrich on 16.2.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFXCObjectsManager.h"
#import "FFXCObject.h"

@interface FFXCObjectsManager ()
@property (nonatomic, strong) NSMutableDictionary *projectFilesPaths;
@end


@implementation FFXCObjectsManager

#pragma mark - Initializer
+ (instancetype)sharedManager
{
    static id SharedManager = nil;
    static dispatch_once_t SharedManagerToken;
    dispatch_once(&SharedManagerToken, ^{
        SharedManager = [[[self class] alloc] init];
    });
    return SharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.projectFilesPaths = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Save and Delete Methods
- (void)saveObject:(FFXCObject *)object forProjectFilePath:(NSURL *)projectFilePath
{
    if (!self.enabled) return;
    
    NSMutableArray *objects = self.projectFilesPaths[projectFilePath.absoluteString];
    if (objects == nil) {
        objects = [[NSMutableArray alloc] init];
        self.projectFilesPaths[projectFilePath.absoluteString] = objects;
    }
    [objects addObject:object];
}

- (void)deleteObject:(FFXCObject *)object ofProjectFilePath:(NSURL *)projectFilePath
{
    if (!self.enabled) return;
    
    [self.projectFilesPaths[projectFilePath.absoluteString] removeObject:object];
}

#pragma mark - Get Saved Objects
- (NSArray *)savedProjectFilesPaths
{
    NSMutableArray *projectFilePaths = [[NSMutableArray alloc] init];
    [self.projectFilesPaths.allKeys enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
        [projectFilePaths addObject:[NSURL URLWithString:path]];
    }];
    return projectFilePaths.copy;
}

- (NSArray *)savedObjectsForProjectFilePath:(NSURL *)projectFilePath
{
    NSArray *savedObjects = [self.projectFilesPaths[projectFilePath.absoluteString] copy];
    if (!savedObjects) savedObjects = [[NSArray alloc] init];
    return savedObjects;
}

#pragma mark - Persisting and Loading
- (BOOL)writeToPath:(NSURL *)path error:(NSError *__autoreleasing *)error
{
    NSData *savedProjectFilePathsData = [NSKeyedArchiver archivedDataWithRootObject:self.projectFilesPaths];
    return [savedProjectFilePathsData writeToURL:path options:NSDataWritingAtomic error:error];
}

- (BOOL)loadFromPath:(NSURL *)path error:(NSError *__autoreleasing *)error
{
    NSData *savedProjectFilePathsData = [NSData dataWithContentsOfURL:path options:kNilOptions error:error];
    if (!savedProjectFilePathsData) return NO;
    
    self.projectFilesPaths = [NSKeyedUnarchiver unarchiveObjectWithData:savedProjectFilePathsData];
    return (self.projectFilesPaths != nil);
}

@end
