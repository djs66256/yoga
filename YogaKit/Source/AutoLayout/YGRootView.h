//
//  YGRootView.h
//  Pods
//
//  Created by daniel on 2017/5/25.
//
//

#import <UIKit/UIKit.h>
#import "YGLayout.h"

@interface YGRootView : UIView

@property (assign, nonatomic) YGDimensionFlexibility dimensionFlexibility;

- (void)invalidateFlexLayout;

@end
