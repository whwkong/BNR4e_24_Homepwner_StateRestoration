//
//  BNRImageStore.m
//  HomePwner
//
//  Created by William Kong on 2014-05-26.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()
- (NSString*)imagePathForKey:(NSString*) key;
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
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
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
    self.dictionary[key] = image;
    
    // create full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    // Turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    // write image to full path
    [data writeToFile:imagePath atomically:YES];
}

// get image
- (UIImage*)imageForKey:(NSString*)key
{
    // if possible, retrieve image from dictionary
    UIImage *result = self.dictionary[key];
    
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        
        // create image from file
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        // if we found an image on file system, place it into cache
        if (result) {
            self.dictionary[key] = result;
        }
        else {
            NSLog(@"Error: unable to find %@", [self imagePathForKey:key]);
        }
    }
    
    return result;
}

// delete imaege
- (void)deleteImageForKey:(NSString*)key
{
    if (!key)
        return;
    
    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath
                                               error:nil];
}

#pragma mark - Archiving & cache methods
- (void)clearCache:(NSNotification*)note
{
    NSLog(@"flushing %d images out of cache,", self.dictionary.count);
    [self.dictionary removeAllObjects];
}

- (NSString*)imagePathForKey:(NSString*) key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    // get one document director from list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    // append file name to path
    return [documentDirectory stringByAppendingPathComponent:key];
}


@end
