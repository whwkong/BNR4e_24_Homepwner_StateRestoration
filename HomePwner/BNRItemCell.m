//
//  BNRItemCell.m
//  HomePwner
//
//  Created by William Kong on 2014-06-13.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

#pragma mark - TableViewCell life cycle
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateInterfaceForDynamicTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}


#pragma mark - Action methods
// called when user clicks button superimposed on image
- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

#pragma mark - Dynamic Type 
- (void)updateInterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
}

@end
