//
//  BNRItemCell.h
//  HomePwner
//
//  Created by William Kong on 2014-06-13.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@property (nonatomic, copy) void(^actionBlock)(void);

@end
