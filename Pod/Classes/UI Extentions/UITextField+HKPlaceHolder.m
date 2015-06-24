//
//  UITextField+HKPlaceHolder.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/24.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UITextField+HKPlaceHolder.h"

@implementation UITextField (HKPlaceHolder)

- (void)setPlaceholderColor:(UIColor *)color
{
    if (self.placeholder.length > 0) {
        
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                  attributes:@{NSForegroundColorAttributeName:color}];
        [self setAttributedPlaceholder:att];
    }
    else if (self.attributedPlaceholder.string.length > 0) {
        
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedPlaceholder];
        [att addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, self.attributedPlaceholder.string.length)];
        [self setAttributedPlaceholder:att];
    }
}


@end
