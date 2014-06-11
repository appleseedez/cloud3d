//
//  CTCaseIndexModel.h
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCaseVO.h"
@interface CTCaseIndexModel : NSObject <UITableViewDataSource>
- initWithCaseList:(NSArray *)caseList;
@end
