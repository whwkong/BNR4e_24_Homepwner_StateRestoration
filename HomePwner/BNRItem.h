//
//  BNRItem.h
//  HomePwner
//
//  Created by William Kong on 2014-06-24.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface BNRItem : NSManagedObject

@property (nonatomic, strong) NSString * itemName;
@property (nonatomic, strong) NSString * serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate * dateCreated;
@property (nonatomic, strong) NSString * itemKey;
@property (nonatomic, strong) UIImage* thumbnail;
@property (nonatomic) double orderingValue;
@property (nonatomic, strong) NSManagedObject *assetType;

- (void)setThumbnailFromImage:(UIImage*)image;
@end
