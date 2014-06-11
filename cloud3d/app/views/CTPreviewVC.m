//
//  CTPreviewVC.m
//  cloud3d
//
//  Created by Zeug on 14-6-5.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTPreviewVC.h"

@interface CTPreviewVC ()

@end

@implementation CTPreviewVC

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
  // Do any additional setup after loading the view.
  self.navigationItem.rightBarButtonItem.action =
      @selector(dismissPreviewPanel);
  self.navigationItem.rightBarButtonItem.target = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Preview Cell"
                                                forIndexPath:indexPath];
  return cell;
}
- (void)dismissPreviewPanel {
  [self.presentingViewController dismissViewControllerAnimated:YES
                                                    completion:nil];
}
@end
