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
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
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
    
    _privateItems = [[NSMutableArray alloc] init];
    
    return self;
}

#pragma mark - Store methods
-(NSArray*) allItems
{
    return self.privateItems;
}

-(BNRItem*) createItem
{
    BNRItem *item = [BNRItem randomItem];
    
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

@end
