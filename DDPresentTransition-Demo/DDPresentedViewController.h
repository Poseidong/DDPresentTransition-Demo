//
//  DDPresentedViewController.h
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/6.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPresentedViewController : UIViewController
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) UIImageView *originalIV;//存储点击位置图片的ImageView

@end
