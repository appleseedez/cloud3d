//
//  CTTextField.m
//  cloud3d
//
//  Created by Arya on 14-6-25.
//  Copyright (c) 2014年 ctceg. All rights reserved.
//

#import "CTTextField.h"

@implementation CTTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}
@end
