//
//  ViewController.m
//  SearchBarDemo
//
//  Created by mofeini on 17/3/24.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "ViewController.h"
#import "XYSearchBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYSearchBar *img = [[XYSearchBar alloc] init];
    [self.view addSubview:img];
    NSDictionary *views = NSDictionaryOfVariableBindings(img);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[img]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[img(44)]" options:kNilOptions metrics:nil views:views]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
