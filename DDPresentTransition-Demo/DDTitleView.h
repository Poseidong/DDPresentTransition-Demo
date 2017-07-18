//
//  DDTitleView.h
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/6.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTitleView : UIView
@property (nonatomic, copy) void(^backBlcok)();


- (void)setEffectViewAlpha:(CGFloat)effectViewAlpha;


@end
