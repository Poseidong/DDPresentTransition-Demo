//
//  DDPresentedViewController.m
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/6.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import "DDPresentedViewController.h"
#import "DDTitleView.h"
#import "DDPresentTransition.h"

@interface DDPresentedViewController ()<UIScrollViewDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DDTitleView *titleView;

@end

@implementation DDPresentedViewController


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        //顶部状态栏状态
        if (self.scrollView.contentOffset.y <= self.imageView.height) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        }else{
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        }
        
        //顶部导航栏透明度
        CGFloat imageHeight = 64;
        CGFloat contentOffsetY = scrollView.contentOffset.y-self.imageView.height+64;
        
        if (contentOffsetY >= 0 && contentOffsetY <= imageHeight) {
            CGFloat alpha = (contentOffsetY)/64.;
            [self.titleView setEffectViewAlpha:alpha];
        } else if (contentOffsetY > imageHeight){
            [self.titleView setEffectViewAlpha:1];
        } else {
            [self.titleView setEffectViewAlpha:0];
            
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    
    
    __weak typeof(self) wself = self;
    [self.view addSubview:self.titleView];
    [self.titleView setEffectViewAlpha:0];
    self.titleView.backBlcok = ^{
        [wself dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.imageView.image = [UIImage imageNamed:self.imageName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazyLoad
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*2);
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (DDTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[[NSBundle mainBundle] loadNibNamed:@"DDTitleView" owner:nil options:nil] firstObject];
        _titleView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    }
    return _titleView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}
#pragma amrk - UIViewControllerTransitioningDelegate
//present
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [DDPresentTransition transitionWithTransitionType:DDPresentTransitionTypePresent originalView:self.originalIV];
}
//dismiss
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DDPresentTransitionType type;
    if (self.scrollView.contentOffset.y > self.imageView.height) {
        type = DDPresentTransitionTypePop;
    }else{
        type =  DDPresentTransitionTypeDismiss;
    }
    return [DDPresentTransition transitionWithTransitionType:type originalView:self.originalIV targetView:self.imageView];
}

@end
