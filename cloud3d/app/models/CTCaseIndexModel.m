//
//  CTCaseIndexModel.m
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseIndexModel.h"
#import "CTCaseIndexCell.h"
@interface CTCaseIndexModel ()
@property(nonatomic, copy) NSArray *caseVOList;
@end
@implementation CTCaseIndexModel
- (id)initWithCaseList:(NSArray *)caseList {
  self.caseVOList = caseList;
  return self;
}
- (void)prepareCell:(CTCaseIndexCell *)cell withVO:(CTCaseVO *)vo {
  [cell.thumbView.layer setBorderColor:[UIColor grayColor].CGColor];
  [cell.thumbView.layer setBorderWidth:.5];
  [cell.thumbView.layer setMasksToBounds:YES];
  NSMutableArray *imageThumbs =
      [[NSMutableArray alloc] initWithCapacity:[vo.caseThumbs count]];

  for (NSString *thumbName in vo.caseThumbs) {
    [imageThumbs addObject:[UIImage imageNamed:thumbName]];
  }

  cell.thumbView.image = [UIImage imageNamed:@"t1"];
  cell.thumbView.animationImages = imageThumbs;
  cell.thumbView.animationRepeatCount = 0;
  cell.thumbView.animationDuration = 1;

  //  cell.textLabel.text = vo.customName;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [self.caseVOList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellIdentifier = @"Case Index Cell";
  CTCaseIndexCell *cell =
      [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                      forIndexPath:indexPath];
  CTCaseVO *caseVO = self.caseVOList[indexPath.row];
  [self prepareCell:cell withVO:caseVO];
  return cell;
}

@end
