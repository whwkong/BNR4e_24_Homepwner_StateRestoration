//
//  BNRItemStore.h
//  HomePwner
//
//  Created by William Kong on 2014-05-17.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

// accessor to all items in store
@property (nonatomic, readonly) NSArray* allItems;

// accessor to singleton
+ (instancetype)sharedStore;

// item is created in store; item is returned.
- (BNRItem*)createItem;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (void)removeItem:(BNRItem*)item;

@end
