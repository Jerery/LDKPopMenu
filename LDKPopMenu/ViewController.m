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
    
    [self.view addSubview:leftTop];
    [self.view addSubview:topCenter];
}

- (void)leftTopButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initWithItems:nil positionType:LDKPopMenuPositionTypeTopLeft origin:CGPointMake(10+50/2, 100) action:nil];
    popMenu.menuColor = [UIColor grayColor];
    popMenu.hasArrow = YES;
    [popMenu show];
}

- (void)topCenterButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initWithItems:nil positionType:LDKPopMenuPositionTypeTopCenter origin:CGPointMake(screenWidth/2, 100) action:nil];
    popMenu.hasArrow = YES;
    [popMenu show];
}

@end
