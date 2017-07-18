//
//  DDPresentTransition.h
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/18.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDPresentTransitionType) {
    DDPresentTransitionTypePresent = 0,
    DDPresentTransitionTypeDismiss,
    DDPresentTransitionTypePop
};


@interface DDPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype _Nonnull )transitionWithTransitionType:(DDPresentTransitionType)type originalView:(UIView *_Nonnull)originalView;

- (instancetype _Nonnull )initWithTransitionType:(DDPresentTransitionType)type originalView:(UIView *_Nonnull)originalView;

+ (instancetype _Nonnull )transitionWithTransitionType:(DDPresentTransitionType)type originalView:(UIView *_Nonnull)originalView targetView:(UIView *_Nonnull)targetView;

- (instancetype _Nonnull )initWithTransitionType:(DDPresentTransitionType)type originalView:(UIView *_Nonnull)originalView  targetView:(UIView *_Nonnull)targetView;

@end
