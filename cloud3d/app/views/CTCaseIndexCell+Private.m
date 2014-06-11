//
//  CTCaseIndexCell+Private.m
//  cloud3d
//
//  Created by Zeug on 14-5-30.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseIndexCell+Private.h"

@implementation CTCaseIndexCell (Private)
- (void)prepareToggleButtonForThumbAnimation {
  UIButton *toggleThumbAnimateButton =
      [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 76.0f, 76.0f)];
  [toggleThumbAnimateButton addTarget:self
                               action:@selector(toggleAnimate)
                     forControlEvents:UIControlEventTouchUpInside];
  toggleThumbAnimateButton.backgroundColor = [UIColor clearColor];
  [self.contentView addSubview:toggleThumbAnimateButton];
  [self.contentView bringSubviewToFront:toggleThumbAnimateButton];
  toggleThumbAnimateButton.center =
      CGPointMake(toggleThumbAnimateButton.bounds.size.width * .5f + 20.0f,
                  self.contentView.center.y);
}
- (void)prepareBackground {
}
- (void)prepareCellToggleButton {
  UIButton *toggleCellButton =
      [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 30.0f)];
  toggleCellButton.backgroundColor = [UIColor redColor];
  [self.contentView addSubview:toggleCellButton];
  [self.contentView bringSubviewToFront:toggleCellButton];
  toggleCellButton.center =
      CGPointMake(self.contentView.bounds.size.width -
                      toggleCellButton.bounds.size.width * 0.5f - 10.0f,
                  toggleCellButton.bounds.size.width * .5f + 10.0f);
}

- (void)toggleAnimate {
  if ([self.thumbView isAnimating]) {
    [self.thumbView stopAnimating];
  } else {
    [self.thumbView startAnimating];
  }
}

@end
