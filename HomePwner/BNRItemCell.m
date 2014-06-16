//
//  BNRItemCell.m
//  HomePwner
//
//  Created by William Kong on 2014-06-13.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
    
}

@end
