//
//  HKThinLine.m
//  HKProjectBase
//
//  Created by Harley.xk on 16/4/19.
//  Copyright © 2016年 Harley.xk. All rights reserved.
//

#import "HKThinLine.h"

@interface HKThinLine ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineConstraint;
@property (assign, nonatomic) IBInspectable CGFloat constant;
@end

@implementation HKThinLine

- (void)layoutSubviews
{
    if (self.lineConstraint) {
        self.lineConstraint.constant = self.constant > 0 ? self.constant : 0.3;
    }
    
    [super layoutSubviews];
}

@end


