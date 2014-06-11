//
//  CTCaseDetailVC+Private.h
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseDetailVC.h"

@interface CTCaseDetailVC (Private)
- (void)prepareButtonsOnNavigationBar;
- (void)prepareToolsFor2D;
- (void)prepareToolsFor3D;
- (void)draw4DivisonGridLine;
- (void)addGLViewShadow;
- (void)preparePopoverController:(CGSize)size;
@end
