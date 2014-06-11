//
//  CTCaseIndexCell.m
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseIndexCell.h"
#import "CTCaseIndexCell+Private.h"
@implementation CTCaseIndexCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)awakeFromNib {
  [self prepareToggleButtonForThumbAnimation];
  [self prepareBackground];
  [self prepareCellToggleButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
