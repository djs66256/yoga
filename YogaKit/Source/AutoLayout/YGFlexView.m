//
//  YGRootView.m
//  Pods
//
//  Created by daniel on 2017/5/25.
//
//

#import "YGFlexView.h"
#import "UIView+Yoga.h"
#import "UIView+Yoga_Private.h"

@implementation YGFlexView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.yoga.width = YGPointValue(self.frame.size.width);
    self.yoga.height = YGPointValue(self.frame.size.height);
    [self.yoga applyLayoutPreservingOrigin:YES];
}

- (CGSize)sizeThatFits:(CGSize)size {
    self.yoga.width = YGPointValue(NAN);
    self.yoga.height = YGPointValue(NAN);
    return [self.yoga calculateLayoutWithSize:size];
}

- (CGSize)intrinsicContentSize {
    self.yoga.width = YGPointValue(NAN);
    self.yoga.height = YGPointValue(NAN);
    CGSize containerSize = CGSizeMake(NAN, NAN);
    if (!(self.yoga.flexDirection == YGFlexDirectionRow && self.yoga.flexWrap == YGWrapNoWrap)) {
        containerSize.width = self.frame.size.width;
    }
    
    if (!(self.yoga.flexDirection == YGFlexDirectionColumn && self.yoga.flexWrap == YGWrapNoWrap)) {
        containerSize.height = self.frame.size.height;
    }
    
    CGSize size = [self.yoga calculateLayoutWithSize:containerSize];
    return size;
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
