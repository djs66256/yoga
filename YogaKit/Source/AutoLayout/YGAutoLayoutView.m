//
//  YGAutoLayoutView.m
//  Meixue
//
//  Created by hzduanjiashun on 2017/5/26.
//  Copyright © 2017年 NetEase. All rights reserved.
//

#import "YGAutoLayoutView.h"

@implementation YGAutoLayoutView

- (CGSize)sizeThatFits:(CGSize)size {
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1
                                                                        constant:size.width];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:1
                                                                        constant:size.height];
    [self addConstraint:widthConstraint];
    [self addConstraint:heightConstraint];
    
    CGSize retSize = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    [self removeConstraint:widthConstraint];
    [self removeConstraint:heightConstraint];
    
    return retSize;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return size;
}

@end
