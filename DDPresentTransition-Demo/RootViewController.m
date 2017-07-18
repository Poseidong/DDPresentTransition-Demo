//
//  RootViewController.m
//  DDPresentTransition-Demo
//
//  Created by Poseidon on 2017/7/6.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import "RootViewController.h"
#import "DDPicCollectionViewCell.h"
#import "DDPresentedViewController.h"


@interface RootViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *picList;

@end

@implementation RootViewController

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPicCollectionViewCell" forIndexPath:indexPath];
    
    NSString *imageName = [self.picList objectAtIndex:indexPath.item];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDPicCollectionViewCell *cell = (DDPicCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *imageName = [self.picList objectAtIndex:indexPath.item];
    DDPresentedViewController *vc = [[DDPresentedViewController alloc] init];
    vc.imageName = imageName;
    vc.originalIV = cell.imageView;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = floor((kScreenWidth-15)/2.);
    return CGSizeMake(width, width);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
//    [self.collectionView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        [_collectionView registerNib:[UINib nibWithNibName:@"DDPicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DDPicCollectionViewCell"];
    }
    return _collectionView;
}

- (NSArray *)picList
{
    if (!_picList) {
        _picList = @[@"0.jpg",@"1.jpeg",@"2.jpeg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpeg",@"9.jpg",@"10.jpg",@"11.jpg",];
    }
    return _picList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
