//
//  BNRItem.m
//  HomePwner
//
//  Created by William Kong on 2014-06-24.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem

@dynamic itemName;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic dateCreated;
@dynamic itemKey;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;


#pragma mark - Item Lifecycle
//  Invoked automatically by the Core Data framework when the receiver is first inserted
//  into a managed object context. This method is invoked only once in the object's lifetime.
- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];
    
    // create an NSUUID object
    NSUUID *uuid = [[NSUUID alloc] init];
    // get the uuid in string form
    NSString *key = [uuid UUIDString];
    self.itemKey = key;
    
}

#pragma mark - Accessor methods
- (void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize = image.size;
    
    // rectangle of thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    // figure out scaling ratio to make sure we maintain the same aspect ratio
    float ratio = MAX(newRect.size.width / origImageSize.width,
                      newRect.size.height / origImageSize.height);
    
    // create a transparent bitmap context with a scaling factor
    // equal to that of screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    // create a path that is a rounded rectangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    // Make all subsequent drawing clip to this rounded rectangle
    [path addClip];
    
    // Center the image in the thumbnail rectangle
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    // draw image on it
    [image drawInRect:projectRect];
    
    // get image from image context; keep it as our thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    // Cleanup image context resources
    UIGraphicsEndImageContext();
}

@end
