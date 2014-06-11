//
//  CTCaseDetailVC.h
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCaseDetailVC
    : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,
                        UIPopoverControllerDelegate>
- (IBAction)active3DTools:(UIButton *)sender;
- (IBAction)active2DTools:(UIButton *)sender;
@property(nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property(nonatomic, weak) IBOutlet UIView *glView;
@property(nonatomic) CGPoint glViewCenter;
@property(nonatomic) UIPopoverController *popoverPanelController;
@end
