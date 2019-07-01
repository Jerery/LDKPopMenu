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
    
    UIButton *topCenter = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2 - 25, 50, 50, 50)];
    [topCenter setTitle:@"中上" forState:UIControlStateNormal];
    topCenter.backgroundColor = [UIColor blackColor];
    [topCenter addTarget:self action:@selector(topCenterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:topCenter];
}

- (void)topCenterButtonClick:(UIButton *)sender {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    LDKPopMenu *popMenu = [[LDKPopMenu alloc] initWithItems:nil origin:CGPointMake(screenWidth/2, 100) action:nil];
    popMenu.hasArrow = YES;
    [popMenu show];
}

@end
