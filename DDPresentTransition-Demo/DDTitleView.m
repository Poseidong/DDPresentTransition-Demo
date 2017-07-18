//
//  DDTitleView.m
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/6.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import "DDTitleView.h"

@interface DDTitleView ()
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation DDTitleView
- (IBAction)backBtnClicked:(id)sender {
    if (self.backBlcok) {
        self.backBlcok();
    };
}

- (void)setEffectViewAlpha:(CGFloat)effectViewAlpha
{
    self.effectView.alpha = effectViewAlpha;
    
    if (effectViewAlpha > 1) {
        self.effectView.alpha = 1;
    }
    if (effectViewAlpha < 0) {
        self.effectView.alpha = 0;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addSubview:self.effectView];
    self.effectView.frame = self.bounds;
    [self sendSubviewToBack:self.effectView];

}

- (UIVisualEffectView *)effectView
{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] init];
        _effectView.backgroundColor = [UIColor clearColor];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView.effect = blur;
    }
    return _effectView;
}


@end
