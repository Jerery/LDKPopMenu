//
//  ViewController.m
//  LDKPopMenu
//
//  Created by Jerery on 2019/7/1.
//  Copyright © 2019 Jerery. All rights reserved.
//

#import "ViewController.h"
#import "LDKPopMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)setupUI {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    
    UIButton *leftTop = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
    [leftTop setTitle:@"左上" forState:UIControlStateNormal];
    leftTop.backgroundColor = [UIColor blackColor];
    [leftTop addTarget:self action:@selector(leftTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *topCenter = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2 - 25, 50, 50, 50)];
    [topCenter setTitle:@"中上" forState:UIControlStateNormal];
    topCenter.backgroundColor = [UIColor blackColor];
    [topCenter addTarget:self action:@selector(topCenterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightTop = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 60, 50, 50, 50)];
    [rightTop setTitle:@"右上" forState:UIControlStateNormal];
    rightTop.backgroundColor = [UIColor blackColor];
    [rightTop addTarget:self action:@selector(rightTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftBottom = [[UIButton alloc] initWithFrame:CGRectMake(10, screenHeight - 150, 50, 50)];
    [leftBottom setTitle:@"左下" forState:UIControlStateNormal];
    leftBottom.backgroundColor = [UIColor blackColor];
    [leftBottom addTarget:self action:@selector(leftBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bottomCenter = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2 - 25, screenHeight - 150, 50, 50)];
    [bottomCenter setTitle:@"中下" forState:UIControlStateNormal];
    bottomCenter.backgroundColor = [UIColor blackColor];
    [bottomCenter addTarget:self action:@selector(bottomCenterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBottom = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 60, screenHeight - 150, 50, 50)];
    [rightBottom setTitle:@"右下" forState:UIControlStateNormal];
    rightBottom.backgroundColor = [UIColor blackColor];
    [rightBottom addTarget:self action:@selector(rightBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftTop];
    [self.view addSubview:topCenter];
    [self.view addSubview:rightTop];
    [self.view addSubview:leftBottom];
    [self.view addSubview:bottomCenter];
    [self.view addSubview:rightBottom];
}

- (void)leftTopButtonClick:(UIButton *)sender {
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initPopMenuWithArrow:NO items:nil positionType:LDKPopMenuArrowPositionTypeTopLeft origin:CGPointMake(10+50/2, 100) action:nil];
    popMenu.menuColor = [UIColor grayColor];
    [popMenu show];
}

- (void)topCenterButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initPopMenuWithArrow:NO items:nil positionType:LDKPopMenuArrowPositionTypeTopCenter origin:CGPointMake(screenWidth/2, 100) action:nil];
    popMenu.menuColor = [UIColor blackColor];
    [popMenu show];
}

- (void)rightTopButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initPopMenuWithArrow:NO items:nil positionType:LDKPopMenuArrowPositionTypeTopRight origin:CGPointMake(screenWidth - 10 - 25, 100) action:nil];
    popMenu.menuColor = [UIColor blueColor];
    [popMenu show];
}

- (void)leftBottomButtonClick:(UIButton *)sender {
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initPopMenuWithArrow:NO items:nil positionType:LDKPopMenuArrowPositionTypeBottomLeft origin:CGPointMake(10+50/2, screenHeight - 150) action:nil];
    popMenu.menuColor = [UIColor redColor];
    [popMenu show];
}

- (void)bottomCenterButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initPopMenuWithArrow:NO items:nil positionType:LDKPopMenuArrowPositionTypeBottomCenter origin:CGPointMake(screenWidth/2, screenHeight - 150) action:nil];
    popMenu.menuColor = [UIColor orangeColor];
    [popMenu show];
}

- (void)rightBottomButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initPopMenuWithArrow:NO items:nil positionType:LDKPopMenuArrowPositionTypeBottomRight origin:CGPointMake(screenWidth - 10 - 25, screenHeight - 150) action:nil];
    popMenu.menuColor = [UIColor purpleColor];
    [popMenu show];
}

@end
