//
//  BNRImageViewController.m
//  HomePwner
//
//  Created by William Kong on 2014-06-16.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRImageViewController.h"

@implementation BNRImageViewController

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // cast the view to UIImageView so compiler knows it is OK to send it setImage
    UIImageView *imageView = (UIImageView*)self.view;
    imageView.image = self.image;
}

@end
