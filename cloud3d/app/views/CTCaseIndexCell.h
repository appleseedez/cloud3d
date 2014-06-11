//
//  CTCaseIndexCell.h
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCaseIndexCell : UITableViewCell
@property(nonatomic, weak)
    IBOutlet UIImageView *thumbView; // always have the imageView
@property(nonatomic, weak) IBOutlet UIView *textContainerView;
@end
