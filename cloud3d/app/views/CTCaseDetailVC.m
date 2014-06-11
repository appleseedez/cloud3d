//
//  CTCaseDetailVC.m
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseDetailVC.h"
#import "CTCaseDetailVC+Private.h"
@interface CTCaseDetailVC ()
@end

@implementation CTCaseDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self prepareButtonsOnNavigationBar];
  [self prepareToolsFor2D];
  [self draw4DivisonGridLine];
  [self addGLViewShadow];
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)active3DTools:(UIButton *)sender {
  [self prepareToolsFor3D];
}

- (void)active2DTools:(UIButton *)sender {
  [self prepareToolsFor2D];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 100;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                forIndexPath:indexPath];
  return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
