//
//  ViewController.m
//  CHKCalendar
//
//  Created by 尊旅环球游 on 2017/7/5.
//  Copyright © 2017年 chk. All rights reserved.
//

#import "ViewController.h"
#import "CHKCalendar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CHKCalendar *calendar = [[CHKCalendar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    
    [self.view addSubview:calendar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
