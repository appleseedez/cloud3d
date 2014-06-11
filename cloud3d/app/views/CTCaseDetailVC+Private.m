//
//  CTCaseDetailVC+Private.m
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseDetailVC+Private.h"
#import "CTPreviewVC.h"
@implementation CTCaseDetailVC (Private)
- (void)addGLViewShadow {
}
// draw the 4 grid line
- (void)draw4DivisonGridLine {
  self.glViewCenter = self.glView.center;
  CALayer *verticalLine = [CALayer layer];
  verticalLine.frame = CGRectMake(self.glView.bounds.size.width * .5, 0, 0.5f,
                                  self.glView.bounds.size.height);
  verticalLine.backgroundColor = [UIColor lightGrayColor].CGColor;
  CALayer *horLine = [CALayer layer];
  horLine.frame = CGRectMake(0, self.glView.bounds.size.height * .5,
                             self.glView.bounds.size.width, 0.5f);
  horLine.backgroundColor = [UIColor lightGrayColor].CGColor;
  [self.glView.layer addSublayer:horLine];
  [self.glView.layer addSublayer:verticalLine];
}
- (void)prepareButtonsOnNavigationBar {
  // create a toolbar to hold the buttons
  UIToolbar *globalButtonbar =
      [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 44.1f)];
  globalButtonbar.clearsContextBeforeDrawing = NO;
  globalButtonbar.clipsToBounds = YES;
  globalButtonbar.tintColor = [UIColor grayColor];
  globalButtonbar.barStyle = -1;
  NSMutableArray *globalButtons = [[NSMutableArray alloc] initWithCapacity:9];
  UIBarButtonItem *b =
      [[UIBarButtonItem alloc] initWithTitle:@"复位"
                                       style:UIBarButtonItemStylePlain
                                      target:nil
                                      action:nil];
  [globalButtons addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 12.0f;
  [globalButtons addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"模板"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(toggleSnapView:)];
  [globalButtons addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 12.0f;
  [globalButtons addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"快照"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(toggleSnapView:)];
  [globalButtons addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 12.0f;
  [globalButtons addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"预览"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(togglePreview)];
  [globalButtons addObject:b];
  [globalButtonbar setItems:globalButtons animated:NO];
  UIBarButtonItem *rightButtonItem =
      [[UIBarButtonItem alloc] initWithCustomView:globalButtonbar];
  self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)prepareToolsFor2D {
  NSMutableArray *toolbarButtonsArray =
      [[NSMutableArray alloc] initWithCapacity:8];
  UIBarButtonItem *b =
      [[UIBarButtonItem alloc] initWithTitle:@"移动"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithTitle:@"窗宽窗位"
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(toggleViewpointWidthAndHeightPanel:)];
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbarButtonsArray addObject:b];

  b = [[UIBarButtonItem alloc] initWithTitle:@"放缩"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@" CT 值"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"更多"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(prepareToolsFor2DMore)];
  [toolbarButtonsArray addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbarButtonsArray addObject:b];
  [self.toolbar setItems:toolbarButtonsArray animated:YES];
}
- (void)prepareToolsFor2DMore {
  NSMutableArray *toolbars = [[NSMutableArray alloc] initWithCapacity:11];
  UIBarButtonItem *b =
      [[UIBarButtonItem alloc] initWithTitle:@"基本操作"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(prepareToolsFor2D)];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"长度"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"角度"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"圆形"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"矩形"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"多边形"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  [self.toolbar setItems:toolbars animated:YES];
}

- (void)prepareToolsFor3D {
  NSMutableArray *toolbars = [[NSMutableArray alloc] initWithCapacity:5];
  UIBarButtonItem *b =
      [[UIBarButtonItem alloc] initWithTitle:@"旋转"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc] initWithTitle:@"缩放"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:nil];
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                           target:nil
                           action:nil];
  b.width = 42.0f;
  [toolbars addObject:b];
  b = [[UIBarButtonItem alloc]
      initWithTitle:@"传输函数"
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(toggleTransportFuncPanel:)];
  [toolbars addObject:b];
  [self.toolbar setItems:toolbars animated:YES];
}
- (void)preparePopoverController:(CGSize)size {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:[NSBundle mainBundle]];
  UIViewController *contentViewController = [sb
      instantiateViewControllerWithIdentifier:@"Panel Content View Controller"];

  self.popoverPanelController = [[UIPopoverController alloc]
      initWithContentViewController:contentViewController];
  self.popoverPanelController.delegate = self;

  self.popoverPanelController.popoverContentSize = size;
}
#pragma mark - button action
- (void)toggleSnapView:(UIBarButtonItem *)b {
  [self.glView pop_removeAnimationForKey:kPOPViewCenter];
  NSValue *destPoint = nil;
  if (self.glView.center.y == self.glViewCenter.y) {
    destPoint =
        [NSValue valueWithCGPoint:CGPointMake(self.glViewCenter.x,
                                              self.glViewCenter.y + 512 - 64)];
  } else {
    destPoint = [NSValue valueWithCGPoint:self.glViewCenter];
  }
  POPSpringAnimation *revealSnapViewOnTheBack = [POPSpringAnimation animation];
  revealSnapViewOnTheBack.property =
      [POPAnimatableProperty propertyWithName:kPOPViewCenter];
  revealSnapViewOnTheBack.toValue = destPoint;
  revealSnapViewOnTheBack.velocity =
      [NSValue valueWithCGPoint:CGPointMake(100, 10)];
  revealSnapViewOnTheBack.springSpeed = 20.0f;
  revealSnapViewOnTheBack.springBounciness = 10.0f;
  [self.glView pop_addAnimation:revealSnapViewOnTheBack forKey:kPOPViewCenter];
}
- (void)togglePreview {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:[NSBundle mainBundle]];
  UINavigationController *np = (UINavigationController *)
      [sb instantiateViewControllerWithIdentifier:@"NavigationToPreviewSB"];
  [self presentViewController:np animated:YES completion:nil];
}
// 传输函数调整框
- (void)toggleTransportFuncPanel:(UIBarButtonItem *)b {

  [self preparePopoverController:CGSizeMake(768.0f, 700.0f)];
  [self.popoverPanelController
      presentPopoverFromBarButtonItem:b
             permittedArrowDirections:UIPopoverArrowDirectionUp
                             animated:YES];
}
- (void)toggleViewpointWidthAndHeightPanel:(UIBarButtonItem *)b {
  [self preparePopoverController:CGSizeMake(768.0f, 500.0f)];
  [self.popoverPanelController
      presentPopoverFromBarButtonItem:b
             permittedArrowDirections:UIPopoverArrowDirectionUp
                             animated:YES];
}
@end
