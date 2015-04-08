//
//  UIView+Utils.m
//  bjj
//
//  Created by Kelvin Lau on 2015-03-02.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void) setDebug
{
    self.layer.borderColor = [UIColor redColor].CGColor;
    
    self.layer.borderWidth = 1.0f;
    
    for (UIView *view in self.subviews) {
        view.layer.borderColor = [UIColor redColor].CGColor;
        
        view.layer.borderWidth = 1.0f;
    }
}

@end
