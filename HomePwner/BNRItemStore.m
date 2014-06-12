//
//  BNRItemStore.m
//  HomePwner
//
//  Created by William Kong on 2014-05-17.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"


@interface BNRItemStore()

@property(nonatomic, strong) NSMutableArray *privateItems;

@end


@implementation BNRItemStore

#pragma mark - Singleton factory
+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    // thread-safe singleton
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

#pragma mark - Class life cycle
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    
    
    NSString *path = [self itemArchivePath];
    
    _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    // if array hadn't been saved previously, create a new empty one
    if (_privateItems == nil) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - Store methods
-(NSArray*) allItems
{
    return self.privateItems;
}

-(BNRItem*) createItem
{
    BNRItem *item = [[BNRItem alloc] init];
    
    [self.privateItems addObject:item];
    
    
    return item; 
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex)
        return;
    
    // Get pointer to object being moved
    BNRItem *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Re-insert item back into array
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (void)removeItem:(BNRItem*)item
{
    // remove image
    BNRImageStore *store = [BNRImageStore sharedStore];
    [store deleteImageForKey:item.itemKey];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

#pragma mark - Archiving methods
- (NSString*)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    // get one document director from list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    // "items.archive" is the name of the file we're archiving to/from.
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    
    // return YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
