//
//  ViewController.m
//  test1
//
//  Created by Xu小波 on 2020/3/17.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "ViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()

@property (nonatomic,   copy) NSArray *array3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:self.view.bounds];
    label.text = @"点触页面跳转web";
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self presentViewController:[[ThreeViewController alloc]init] animated:YES completion:nil];
}

@end
