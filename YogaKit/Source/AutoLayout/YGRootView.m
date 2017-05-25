//
//  YGRootView.m
//  Pods
//
//  Created by daniel on 2017/5/25.
//
//

#import "YGRootView.h"
#import "UIView+Yoga.h"
#import "UIView+Yoga_Private.h"

@implementation YGRootView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    YGValue width;
    YGValue height;
    if (_dimensionFlexibility & YGDimensionFlexibilityFlexibleWidth) {
        width = YGValueAuto;
    }
    else {
        width = YGPointValue(self.frame.size.width);
    }
    if (_dimensionFlexibility & YGDimensionFlexibilityFlexibleHeigth) {
        height = YGValueAuto;
    }
    else {
        height = YGPointValue(self.frame.size.height);
    }
    
    BOOL needInvalidateContentSize = !YGValueEqual(self.yoga.width, width) || !YGValueEqual(self.yoga.height, height);
    if (needInvalidateContentSize) {
        [self invalidateIntrinsicContentSize];
    }
    [self.yoga applyLayoutPreservingOrigin:YES dimensionFlexibility:_dimensionFlexibility];
}

- (void)setDimensionFlexibility:(YGDimensionFlexibility)dimensionFlexibility {
    if (_dimensionFlexibility != dimensionFlexibility) {
        _dimensionFlexibility = dimensionFlexibility;
        [self setNeedsLayout];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    return self.yoga.intrinsicSize;
}

- (CGSize)intrinsicContentSize {
    return self.yoga.intrinsicSize;
}

static void YGMarkSubNodesDirty(UIView *view) {
    for (UIView *subview in view.subviews) {
        YGLayout *yoga = subview.yogaNoLazilyCreated;
        if (yoga) {
            [yoga markDirty];
            YGMarkSubNodesDirty(subview);
        }
    }
}

- (void)invalidateFlexLayout {
    YGMarkSubNodesDirty(self);
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

@end
