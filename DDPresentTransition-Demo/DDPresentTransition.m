//
//  DDPresentTransition.m
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/18.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import "DDPresentTransition.h"

@interface DDPresentTransition ()
@property (nonatomic, assign) DDPresentTransitionType type;
@property (nonatomic, strong) UIView *originalView;//存储点击位置图片的View
@property (nonatomic, strong) UIView *targetView;//存储将要显示位置图片的View

@property (nonatomic, strong) UIView *tempView;//实现动画的View

@end

@implementation DDPresentTransition

#pragma mark - init
+ (instancetype _Nonnull )transitionWithTransitionType:(DDPresentTransitionType)type  originalView:(UIView *_Nonnull)originalView
{
    return [[self alloc] initWithTransitionType:type originalView:originalView];
}

- (instancetype _Nonnull )initWithTransitionType:(DDPresentTransitionType)type  originalView:(UIView *_Nonnull)originalView
{
    self = [super init];
    if (self) {
        _type = type;
        _originalView = originalView;
    }
    return self;
}

+ (instancetype _Nonnull )transitionWithTransitionType:(DDPresentTransitionType)type  originalView:(UIView *_Nonnull)originalView targetView:(UIView *_Nonnull)targetView
{
    return [[self alloc] initWithTransitionType:type originalView:originalView targetView:targetView];
}

- (instancetype _Nonnull )initWithTransitionType:(DDPresentTransitionType)type  originalView:(UIView *_Nonnull)originalView  targetView:(UIView *_Nonnull)targetView
{
    self = [super init];
    if (self) {
        _type = type;
        _originalView = originalView;
        _targetView = targetView;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_type == DDPresentTransitionTypePresent) {
        return 0.25;
    }else if (_type == DDPresentTransitionTypeDismiss) {
        return 0.25;
    }else{
        return 0.35;
    }
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case DDPresentTransitionTypePresent:
            [self presentAnimateTransition:transitionContext];
            break;
            
        case DDPresentTransitionTypeDismiss:
            [self dismissAnimateTransition:transitionContext];
            break;
            
        case DDPresentTransitionTypePop:
            [self popAnimateTransition:transitionContext];
            break;
            
            
        default:
            break;
    }

}

#pragma mark - useMethod
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    
    //立即获取视图快照 并计算在屏幕中的frame
    self.tempView = [self.originalView snapshotViewAfterScreenUpdates:NO];
    self.tempView.frame = [self.originalView convertRect:self.originalView.bounds toView:nil];
    
    self.originalView.hidden = YES;
    toVC.view.alpha = 0;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:self.tempView];
    
    //计算图片的比例
    CGSize imageSize = self.originalView.bounds.size;
    CGFloat imageH = ceil(imageSize.height);
    CGFloat imageW = ceil(imageSize.width);
    CGFloat height = ceil(kScreenWidth*imageH/imageW);
    
    //执行转场动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.tempView.frame = CGRectMake(0, 0, kScreenWidth, height);
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        self.tempView.hidden = YES;
        [self.tempView removeFromSuperview];
        self.tempView = nil;
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    
    self.tempView = [self.targetView snapshotViewAfterScreenUpdates:NO];
    self.tempView.frame = [self.targetView convertRect:self.targetView.bounds toView:nil];
    self.tempView.hidden = NO;
    [containerView addSubview:self.tempView];
    
    self.originalView.hidden = YES;
    fromVC.view.hidden = YES;
    toVC.view.alpha = 0;
    
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.tempView.frame = [self.originalView convertRect:self.originalView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        self.originalView.hidden = NO;
        self.tempView.hidden = YES;
        [self.tempView removeFromSuperview];
        self.tempView = nil;
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    
    [containerView insertSubview:toVC.view atIndex:0];
    toVC.view.alpha = 1;
    toVC.view.x = -100;
    self.originalView.hidden = NO;
    
    [containerView addSubview:fromVC.view];
    fromVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromVC.view.layer.shadowOpacity = 0.5;
    fromVC.view.layer.shadowRadius = 3;
    fromVC.view.layer.shadowOffset = CGSizeMake(-1, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.x = 0;
        fromVC.view.x = kScreenWidth;
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}


@end
