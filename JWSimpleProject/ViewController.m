//
//  ViewController.m
//  JWSimpleProject
//
//  Created by huangjw on 2017/1/6.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import "ViewController.h"
#import "TableViewSimpleVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Master";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jump:(id)sender {
    TableViewSimpleVC *table = [[TableViewSimpleVC alloc] init];
    [self.navigationController pushViewController:table animated:YES];
}

@end
