//
//  UIView+Yoga_Private.h
//  Pods
//
//  Created by daniel on 2017/5/25.
//
//

#ifndef UIView_Yoga_Private_h
#define UIView_Yoga_Private_h

@interface UIView (Yoga)

/**
 The YGLayout that is attached to this view. It is without lazily created.
 */
@property (nonatomic, readonly, strong) YGLayout *yogaNoLazilyCreated;

@end

#endif /* UIView_Yoga_Private_h */
