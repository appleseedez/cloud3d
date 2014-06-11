//
//  CTCaseVO.h
//  cloud3d
//
//  Created by Zeug on 14-5-29.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCaseVO : NSObject
@property(nonatomic, copy) NSArray *caseThumbs;
@property(nonatomic, copy) NSString *customName;
@property(nonatomic, copy) NSString *customSeqenceNumber;
@property(nonatomic) NSUInteger gender;
@property(nonatomic, copy) NSString *department;
@property(nonatomic) NSDate *createDate;
@property(nonatomic) NSDate *updateDate;
@end
