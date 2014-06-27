//
//  BNRDetailViewController.h
//  HomePwner
//
//  Created by William Kong on 2014-05-22.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);
- (instancetype)initForNewItem:(BOOL) isNew;

@end
