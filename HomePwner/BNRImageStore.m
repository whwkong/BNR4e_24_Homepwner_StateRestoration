//
//  BNRImageStore.m
//  HomePwner
//
//  Created by William Kong on 2014-05-26.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()
@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

#pragma mark - Singleton factory
+ (instancetype)sharedStore
{
    static BNRImageStore *imageStore = nil;
    
    // thread-safe singleton
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageStore = [[self alloc] initPrivate];
    });
    
    return imageStore;
}

#pragma mark - Store life cycle
// Prevent public usage of init
- (instancetype)init
{
    NSException *exception = [[NSException alloc] initWithName:@"Singleton"
                                                        reason:@"Use +[BNRImageStore sharedStore] instead"
                                                      userInfo:nil];
    @throw exception;
    return nil;
}

// Private designated initializer
- (instancetype) initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Store getter/setters
// add image
- (void)setImage:(UIImage*)image forKey:(NSString*)key
{
    if (!key)
        return;
    // add image to dictionary
    [self.dictionary setObject:image forKey:key];
}

// get image
- (UIImage*)imageForKey:(NSString*)key
{
    return [self.dictionary objectForKey:key];
}

// delete imaege
- (void)deleteImageForKey:(NSString*)key
{
    if (!key)
        return;
    
    [self.dictionary removeObjectForKey:key];
}



@end
