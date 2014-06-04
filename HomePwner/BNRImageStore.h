//
//  BNRImageStore.h
//  HomePwner
//
//  Created by William Kong on 2014-05-26.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
{
}

+ (instancetype)sharedStore;

// add image
- (void)setImage:(UIImage*)image forKey:(NSString*)key;
// get image
- (UIImage*)imageForKey:(NSString*)key;
// delete iamge
- (void)deleteImageForKey:(NSString*)key;


@end
