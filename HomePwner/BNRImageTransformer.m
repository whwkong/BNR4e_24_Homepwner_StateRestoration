//
//  BNRImageTransformer.m
//  HomePwner
//
//  Created by William Kong on 2014-06-24.
//  Copyright (c) 2014 William Kong. All rights reserved.
//
//  This class is responsible for transforming thumbnail image data to/from Core Data.

#import "BNRImageTransformer.h"

@implementation BNRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

// Called when data is saved to the file system.
// The argument to the method is a UIImage, and will return an instance of NSData.
- (id)transformedValue:(id)value
{
    if (!value)
        return nil;
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    // Returns NSData object for the specified image in PNG format
    return UIImagePNGRepresentation(value);
}

// Called when the thumbnail data is loaded from file system.
// An UIImage object is created from the NSData that was stored.  
- (id)reverseTransformedValue:(id)value
{
    // Creates and returns an image object that uses the specified image data.
    return [UIImage imageWithData:value];
}


@end
