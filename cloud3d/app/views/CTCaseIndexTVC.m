//
//  CTCaseIndexTVC.m
//  cloud3d
//
//  Created by Zeug on 14-5-28.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTCaseIndexTVC.h"
#import "CTCaseIndexTVC+Private.h"
#import "CTCaseIndexModel.h"
@interface CTCaseIndexTVC ()
// index data source
@property(nonatomic) CTCaseIndexModel *dataSourceModel;
@end

@implementation CTCaseIndexTVC
- (void)viewDidLoad {
  [super viewDidLoad];
  self.clearsSelectionOnViewWillAppear = NO;
  self.navigationItem.backBarButtonItem.title = @"病例列表";
// 1. execute the query.
// after that i wait the result to return
// 2. parse the result set
// after that i can get the enough meta info to build vo
// 3. using the table header meta to build the vo
// 4. fetch the thumbs packages from ftp
//
#if Test_CaseIndex
  /** test case**/
  NSMutableArray *caseList = [[NSMutableArray alloc] initWithCapacity:20];
  CTCaseVO *vo = nil;
  for (NSUInteger i = 0; i < 20; i++) {
    vo = [CTCaseVO new];
    vo.customName = @"坦克";
    vo.caseThumbs = @[ @"t1", @"t2", @"t3", @"t4" ];
    [caseList addObject:vo];
  }

  self.dataSourceModel = [[CTCaseIndexModel alloc] initWithCaseList:caseList];

#else

  self.dataSourceModel = [[CTCaseIndexModel alloc] initWithCaseList:@[]];
#endif

  // must use a property. the datasource is not retain;
  self.tableView.dataSource = self.dataSourceModel;
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self prepareButtonsOnNavigationBar];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 130.0f;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
